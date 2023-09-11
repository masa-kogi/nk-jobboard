class Admins::ApplicantsController < ApplicationController
  # helper Recruiters::ApplicantsHelper
  protect_from_forgery except: :index
  # before_action :set_instances_for_form, only: [:index, :show]
  before_action :set_root_departments, only: [:index, :show]

  def index
    @job = Job.find(params[:job_id])

    if params[:status].present?
      status_filter = [params[:status].to_i]
    elsif params[:status] == ''
      status_filter = ApplicationStatus.pluck(:id)
    else
      status_filter = [ApplicationStatus.find_by(name: '応募中').id] # デフォルトは公開中の求人のみを表示
    end

    sub_query = ApplicationStatusMap.select('job_application_id, MAX(created_at) as max_created_at').group(:job_application_id)

    @q = @job.applicants.ransack(params[:q])
    @applicants = @q.result
            .includes(:job_applications)
            .joins(job_applications: :application_status_maps)
            .joins("INNER JOIN (#{sub_query.to_sql}) AS latest_statuses ON job_applications.id = latest_statuses.job_application_id AND application_status_maps.created_at = latest_statuses.max_created_at")
            .where(application_status_maps: { application_status_id: status_filter })
            .order('application_status_maps.created_at DESC')
            .page(params[:page]).per(10).all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @job = Job.find(params[:job_id])
    # @job_application = @job.job_applications.find(params[:id])
    @job_application = JobApplication.find_by(job_id: @job.id, applicant_id: params[:id])

  # エラーハンドリング: 期待されるJobApplicationが存在しない場合はエラーメッセージを表示
    unless @job_application
      redirect_to recruiter_job_applicants_path, alert: '対象の応募情報が見つかりませんでした。'
      return
    end

    @applicant = @job_application.applicant
    @current_status = @job_application.current_status # 後ほどこのメソッドをモデルに定義します
  end

  def update
    @job = Job.find(params[:job_id])
    @job_application = JobApplication.find_by(job_id: @job.id, applicant_id: params[:id])

    new_status_id = job_application_params[:application_status_id].to_i

    if new_status_id == @job_application.current_status.id
      redirect_to recruiter_job_applicant_path(current_recruiter, @job, @job_application.applicant_id), alert: 'ステータスは変更されていません'
      return
    end

    if new_status_id.present?
      ApplicationStatusMap.create!(job_application_id: @job_application.id, application_status_id: new_status_id)
      redirect_to recruiter_job_applicants_path, notice: '応募状況を更新しました'
    else
      redirect_to recruiter_job_applicant_path(current_recruiter, @job, @job_application.applicant_id), alert: 'ステータスの更新に失敗しました'
    end
  end

  private

  def set_root_departments
    @root_departments = Department.where(ancestry: nil)
  end

  # def job_application_params
  #   {
  #     application_status_id: params[:application_status_id]
  #   }
  # end

  # def set_instances_for_form
  #   set_recruiter_department
  #   set_recruiter_department_name
  #   set_recruiter_sub_departments
  #   set_recruiter_department_depth
  # end

  # def set_recruiter_department
  #   @recruiter_department = current_recruiter.recruiter_profile.department
  # end

  # def set_recruiter_department_name
  #   @recruiter_department_name = @recruiter_department.path.map(&:name).join
  # end

  # def set_recruiter_sub_departments
  #   @recruiter_sub_departments = @recruiter_department.subtree
  # end

  # def set_recruiter_department_depth
  #   @recruiter_department_depth = @recruiter_department.depth
  # end

  def set_application_statuses
    @application_statuses = ApplicationStatus.all
  end
end
