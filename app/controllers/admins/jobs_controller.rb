class Admins::JobsController < ApplicationController
  protect_from_forgery except: :index
  before_action :set_root_departments, only: [:index, :show]
  before_action :set_job_statuses, only: [:index]

  def index
    # public_status_id = JobStatus.find_by(name: '公開中').id
    if params[:status].present?
      status_filter = [params[:status].to_i]
    elsif params[:status] == ''
      status_filter = JobStatus.pluck(:id)
    else
      status_filter = [JobStatus.find_by(name: '公開中').id] # デフォルトは公開中の求人のみを表示
    end


    if params[:department].present? && params[:department] =~ /\A\d+\z/
      department_filter = Department.find(params[:department].to_i).subtree.pluck(:id)
      @department_name = Department.find_by(id: params[:department]).path.map(&:name).join
    else
      department_filter = Department.all.pluck(:id)
      @department_name = "すべて部門の求人"
    end

    sub_query = JobStatusMap.select('job_id, MAX(created_at) as max_created_at').group(:job_id)

    @q = Job.ransack(params[:q])
    @jobs = @q.result
          .includes(:category, job_status_maps: :job_status)
          .joins(:job_status_maps)
          .joins("INNER JOIN (#{sub_query.to_sql}) AS latest_statuses ON job_status_maps.job_id = latest_statuses.job_id AND job_status_maps.created_at = latest_statuses.max_created_at")
          .where(department_id: department_filter, job_status_maps: { job_status_id: status_filter })
          .order('job_status_maps.created_at DESC')
          .page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js # これを追加
    end
  end

  def show
    @job = Job.find(params[:id])
  end

  private

  def set_root_departments
    @root_departments = Department.where(ancestry: nil)
  end

  def set_job_statuses
    @job_statuses = JobStatus.all
  end
end
