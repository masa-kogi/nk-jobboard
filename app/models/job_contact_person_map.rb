class JobContactPersonMap < ApplicationRecord
  belongs_to :job
  belongs_to :contact_person, class_name: 'RecruiterProfile'
end
