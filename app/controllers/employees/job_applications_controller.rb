class Employees::JobApplicationsController < ApplicationController
  protect_from_forgery except: :index
  before_action :authenticate_employee!
  before_action :set_job, only: [:new, :confirm, :create]
  before_action :set_root_departments, only: [:index, :new, :confirm, :create, :show]

  def index
    job_ids = current_employee.employee_profile.job_applications.order(created_at: :desc).pluck(:job_id)

    @q = Job.where(id: job_ids).ransack(params[:q])
    @jobs = @q.result.order(Arel.sql("FIELD(id, #{job_ids.join(',')})")).includes(:job_applications).page(params[:page]).per(10)

    @application_statuses = {}
    @application_dates = {}

    @jobs.each do |job|
      job_application = JobApplication.find_by(job: job, applicant: current_employee.employee_profile)
      # @application_statuses[job.id] = job_application&.current_status
      @application_statuses[job.id] = job_application.current_status.name if job_application

      application_date = job_application&.created_at
      @application_dates[job.id] = application_date
    end
  end

  def new
    if JobApplication.exists?(job: @job, applicant: current_employee.employee_profile)
      redirect_to job_path(params[:job_id]), alert: '既に応募済みです。'
      return
    end

    if @job.department == current_employee.employee_profile.department
      redirect_to job_path(params[:job_id]), alert: '自分の所属する部門の求人には応募できません。'
      return
    end

    @job_application = if session[:job_application_data]
                      data = session[:job_application_data]
                      session.delete(:job_application_data)
                      JobApplication.new(data)
                    else
                      JobApplication.new
                    end
  end


  def confirm
    @job_application = JobApplication.new(job_application_params.merge({
      job_id: @job.id,
      applicant_id: current_employee.employee_profile.id
    }))
    session[:job_application_data] = job_application_params

    unless @job_application.valid?
      Rails.logger.debug(@job_application.errors.full_messages)
      render :new
    end
  end

  def create
    @job_application = @job.job_applications.new(session[:job_application_data])
    @job_application.applicant = current_employee.employee_profile  # 仮にcurrent_employeeメソッドが現在のEmployeeを返すとします。

    if @job_application.save
      session.delete(:job_application_data)  # セッションのクリア
      redirect_to employee_job_applications_path(current_employee), notice: '応募が完了しました'
    else
      puts @job_application.errors.full_messages
      puts "Session data: #{session[:job_application_data]}"
      render :new
    end
  end

  def show
    @job_application = JobApplication.find(params[:id])
    @job = @job_application.job
  end


  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def job_application_params
    # 必要なパラメータを許可します
    params.require(:job_application).permit(:reason_for_application, :self_promotion)
  end

  def set_root_departments
    @root_departments = Department.where(ancestry: nil)
  end
end
