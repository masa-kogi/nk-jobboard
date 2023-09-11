class Employees::JobsController < ApplicationController
  protect_from_forgery except: :index
  before_action :set_root_departments, only: [:index, :show]
  before_action :set_categories, only: [:index]

  def index
    public_status_id = JobStatus.find_by(name: '公開中').id

    category_filter = if params[:category].present?
      category = Category.find(params[:category].to_i)
    else
      Category.all.pluck(:id)
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
          .where(department_id: department_filter, category_id: category_filter, job_status_maps: { job_status_id: public_status_id })
          .order('job_status_maps.created_at DESC')
          .page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js # これを追加
    end
  end

  def show
    session.delete(:job_application_data) if session[:job_application_data]
    @job = Job.find(params[:id])

    # if current_employee
    #   @already_applied = JobApplication.exists?(job: @job, applicant: current_employee.employee_profile)
    # else
    #   @already_applied = false
    # end
    if current_employee
      @already_applied = JobApplication.exists?(job: @job, applicant: current_employee.employee_profile)
      @same_department = @job.department == current_employee.employee_profile.department
    else
      @already_applied = false
      @same_department = false
    end
  end

  private

  def set_root_departments
    @root_departments = Department.where(ancestry: nil)
  end

  def set_categories
    @categories = Category.all
  end
end
