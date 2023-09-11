class RecruiterProfile < ApplicationRecord
  belongs_to :recruiter
  belongs_to :position
  belongs_to :department
  has_many :job_contact_person_maps, foreign_key: 'contact_person_id', dependent: :destroy
  has_many :jobs, through: :job_contact_person_maps

  def full_name
    "#{last_name} #{first_name}"
  end
end
