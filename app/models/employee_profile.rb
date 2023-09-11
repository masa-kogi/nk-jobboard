class EmployeeProfile < ApplicationRecord
  belongs_to :employee
  belongs_to :position
  belongs_to :department

  has_many :job_applications, foreign_key: 'applicant_id'
  has_many :jobs, through: :job_applications

  def full_name
    "#{last_name} #{first_name}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "department_id", "employee_id", "first_name", "global_search", "id", "last_name", "position_id", "qualifications", "skills", "updated_at"]
  end

  ransacker :global_search do |parent|
    Arel::Nodes::NamedFunction.new('CONCAT_WS',
      [Arel::Nodes.build_quoted(' '), parent.table[:first_name], parent.table[:last_name], parent.table[:qualifications], parent.table[:skills],
       JobApplication.arel_table[:reason_for_application], JobApplication.arel_table[:self_promotion]]
    )
  end

end
