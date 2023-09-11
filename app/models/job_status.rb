class JobStatus < ApplicationRecord
  has_many :jobs, through: :job_status_maps
  has_many :job_status_maps
end
