class Recruiters::JobsController < ApplicationController
  helper Recruiters::JobsHelper
  protect_from_forgery except: :index
  before_action :authenticate_recruiter!
  before_action :set_instances_for_form, only: [:index, :back, :new, :confirm, :create, :edit, :edit_confirm, :back_edit, :update]
  before_action :set_job_statuses, only: [:index]

  def index
    session.delete(:job) if session[:job]
    @recruiter_sub_departments = @recruiter_department.subtree
    if params[:status].present?
      status_filter = [params[:status].to_i]
    elsif params[:status] == ''
      status_filter = JobStatus.pluck(:id)
    else
      status_filter = [JobStatus.find_by(name: '公開中').id] # デフォルトは公開中の求人のみを表示
    end

    if params[:department].present? && params[:department] =~ /\A\d+\z/
      department_filter = [params[:department].to_i]
      @department_name = Department.find_by(id: params[:department]).path.map(&:name).drop(@recruiter_department_depth + 1).join
    else
      department_filter = @recruiter_sub_departments.pluck(:id)
      @department_name = @recruiter_department_name
    end

    sub_query = JobStatusMap.select('job_id, MAX(created_at) as max_created_at').group(:job_id)

    @q = Job.ransack(params[:q])
    @jobs = @q.result
            .includes(:category, :job_applications, job_status_maps: :job_status)
            .joins(:job_status_maps)
            .joins("INNER JOIN (#{sub_query.to_sql}) AS latest_statuses ON job_status_maps.job_id = latest_statuses.job_id AND job_status_maps.created_at = latest_statuses.max_created_at")
            .where(department_id: department_filter, job_status_maps: { job_status_id: status_filter })
            .order('job_status_maps.created_at DESC')
            .page(params[:page]).per(10).all

    respond_to do |format|
      format.html
      format.js # これを追加
    end
  end

  def new
    if session[:job]
      @job = Job.new(session[:job])
      @recruiters = RecruiterProfile.where(department_id: @job.department_id)
      # @contact_persons = RecruiterProfile.where(id: session[:job]["contact_person_ids"].reject(&:blank?)).pluck(:id)
      @contact_person_ids = session.dig(:job, "contact_person_ids")&.reject(&:blank?) || []
      session.delete(:job)
    else
      @job = Job.new
    end
  end

  def confirm
    @job = Job.new(job_params)
    if @job.valid?
      @current_job_status = JobStatus.find(@job.job_status_id).name
      @contact_persons = RecruiterProfile.where(id: @job.contact_person_ids.reject(&:blank?))
      session[:job] = job_params
    else
      set_instances_for_form
      @contact_person_ids = @job.contact_person_ids.reject(&:blank?)
      render :new
    end
  end

  def create
    @job = Job.new(session[:job])
    contact_person_ids = RecruiterProfile.where(id: session[:job]["contact_person_ids"].reject(&:blank?)).pluck(:id)
    session.delete(:job)
    if @job.save
      @job.update_contact_persons(contact_person_ids)
      redirect_to recruiter_jobs_path, notice: '新規求人を作成しました'
    else
      set_instances_for_form
      @recruiters = @job.department.recruiter_profiles
      render :new
    end
  end

def edit
  @job = Job.find(params[:id])
  @recruiters = @job.department.recruiter_profiles
  @contact_person_ids = @job.contact_persons.pluck(:id)
  @job.job_status_id = @job.job_status_maps.last&.job_status_id
  if session[:job]
    @job.assign_attributes(session[:job])
    @contact_person_ids = @job.contact_person_ids
    session.delete(:job)
  end
  @job.previous_job_status_id = @job.current_status
end

  def edit_confirm
    @job = Job.find(params[:id])
    @job.assign_attributes(job_params)
    @current_job_status = JobStatus.find(@job.job_status_id).name
    @contact_persons = RecruiterProfile.where(id: @job.contact_person_ids.reject(&:blank?))
    session[:job] = job_params.merge(id: @job.id)
    render :edit if @job.invalid?
  end


  def update
    @job = Job.find(session[:job]['id'])
    @job.assign_attributes(session[:job])
    contact_person_ids = session[:job]['contact_person_ids']
    session.delete(:job)
    if @job.save
      @job.update_contact_persons(contact_person_ids)
      redirect_to recruiter_jobs_path, notice: '求人情報を更新しました'
    else
      set_instances_for_form
      render :edit
    end
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy
    redirect_to recruiter_jobs_path, notice: "求人を削除しました。"
  end


  def fetch_recruiters
    @recruiters = RecruiterProfile.where(department_id: params[:department_id])
    respond_to do |format|
      format.json { render json: @recruiters.map { |r| { id: r.id, name: r.full_name } } }
    end
  end

  private

  def job_params
    params.require(:job).permit(:category_id, :title, :department_id, :work_location_id, :job_description, :application_requirement, :job_status_id, contact_person_ids: []).tap do |whitelisted|
      contact_ids = whitelisted[:contact_person_ids].reject(&:blank?)
      whitelisted[:contact_person_ids] = contact_ids
    end
  end


  def set_instances_for_form
    set_recruiter_department
    set_recruiter_department_name
    set_recruiter_sub_departments
    set_recruiter_department_depth
    set_categories
    set_work_locations
    department_id = params.dig(:job, :department_id) || @job&.department_id
    @recruiters = RecruiterProfile.where(department_id: department_id) if department_id.present?
  end

  def set_recruiter_department
    @recruiter_department = current_recruiter.recruiter_profile.department
  end

  def set_recruiter_department_name
    @recruiter_department_name = @recruiter_department.path.map(&:name).join
  end

  def set_recruiter_sub_departments
    @recruiter_sub_departments = @recruiter_department.subtree
  end

  def set_recruiter_department_depth
    @recruiter_department_depth = @recruiter_department.depth
  end

  def set_categories
    @categories = Category.all
  end

  def set_job_statuses
    @job_statuses = JobStatus.all
  end

  def set_work_locations
    @work_locations = WorkLocation.all
  end

end
