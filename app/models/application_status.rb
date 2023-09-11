class ApplicationStatus < ApplicationRecord
  has_many :job_application_maps
  has_many :job_applications, through: :application_status_maps
end
