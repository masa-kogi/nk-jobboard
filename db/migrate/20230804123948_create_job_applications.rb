class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.references :job, null: false, foreign_key: true
      t.references :applicant, null: false, foreign_key: { to_table: :employee_profiles }
      t.text :reason_for_application, null: false
      t.text :self_promotion, null: false
      t.timestamps
    end
  end
end
