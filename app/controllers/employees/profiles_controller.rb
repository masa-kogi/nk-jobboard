class Employees::ProfilesController < ApplicationController
  before_action :authenticate_employee!
  before_action :set_root_departments, only: [:show, :edit, :update, :edit_confirm]
  before_action :set_employee_profile, only: [:show, :edit, :update, :edit_confirm]

  def show
  end

  def edit
    # セッションに変更内容が存在する場合、それを@employee_profileに適用する
    if session[:temp_profile_params]
      @employee_profile.assign_attributes(session[:temp_profile_params])
      session.delete(:temp_profile_params)  # セッションの変更内容をクリアする
    end
  end

  def edit_confirm
    @employee_profile.assign_attributes(profile_params)
    unless @employee_profile.valid?
      render :edit
    else
      # バリデーションが成功した場合、変更内容をセッションに保存する
      session[:temp_profile_params] = profile_params
    end
  end

  def update
    # 更新処理が成功したら、セッションの変更内容をクリアする
    if @employee_profile.update(profile_params)
      session.delete(:temp_profile_params)
      redirect_to employee_profile_path, notice: 'プロファイルを更新しました。'
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:employee_profile).permit(:qualifications, :skills)
  end

  def set_root_departments
    @root_departments = Department.where(ancestry: nil)
  end

  def set_employee_profile
    @employee_profile = current_employee.employee_profile
  end
end
