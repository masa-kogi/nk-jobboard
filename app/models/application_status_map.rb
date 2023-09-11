class ApplicationStatusMap < ApplicationRecord
  belongs_to :job_application
  belongs_to :application_status
end
