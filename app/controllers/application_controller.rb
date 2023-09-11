class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception # この行を追加
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    elsif resource_or_scope == :employee
      root_path
    elsif resource_or_scope == :recruiter
      new_recruiter_session_path
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email]) # 注目
    end
end
