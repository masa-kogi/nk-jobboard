module ApplicationHelper
  def job_application_for_current_employee(job)
    JobApplication.find_by(job: job, applicant: current_employee.employee_profile)
  end

  def job_status_color(status_name)
    case status_name
    when '未公開'
      'bg-gray-200 text-gray-900'
    when '公開中'
      'bg-green-200 text-green-900'
    when '募集終了'
      'bg-red-200 text-red-900'
    else
      'bg-blue-200 text-blue-900' # 予期しないステータスの場合のデフォルトの色
    end
  end

  def application_status_color(status_name)
    case status_name
    when '応募中'
      'bg-yellow-300'
    when '合格'
      'bg-green-300'
    when '不合格'
      'bg-red-300'
    else
      'bg-gray-300'
    end
  end
end
