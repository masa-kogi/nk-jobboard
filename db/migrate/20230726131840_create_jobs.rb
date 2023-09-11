class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.references :category, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.references :work_location, null: false, foreign_key: true
      # t.references :contact_person, null: false, foreign_key: { to_table: :recruiters }
      t.text :job_description, null: false
      t.text :application_requirement, null: false

      t.timestamps
    end
  end
end
