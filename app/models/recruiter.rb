class Recruiter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :recruiter_profile, dependent: :destroy
  # belongs_to :department
  # has_many :job_contact_person_maps, foreign_key: :contact_person_id
  # has_many :jobs, through: :job_contact_person_maps

  def to_param
    username
  end
end
