class Department < ApplicationRecord
  has_ancestry
  has_many :recruiter_profiles
  has_many :jobs

  def path_name
    self.path.map(&:name).join
  end
end
