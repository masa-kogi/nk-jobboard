class JobApplication < ApplicationRecord
  belongs_to :job
  belongs_to :applicant, class_name: "EmployeeProfile"

  has_many :application_status_maps
  has_many :application_statuses, through: :application_status_maps

  with_options presence: true do
     validates :reason_for_application
     validates :self_promotion
  end

  after_create :assign_default_status

  def current_status
    self.application_status_maps.order(created_at: :desc).first&.application_status
  end

  private

  # デフォルトのステータス（"応募中"）を関連付けるメソッド
  def assign_default_status
    default_status = ApplicationStatus.find_by(name: "応募中")
    self.application_status_maps.create(application_status: default_status)
  end
end
