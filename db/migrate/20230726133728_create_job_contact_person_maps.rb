class CreateJobContactPersonMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :job_contact_person_maps do |t|
      t.references :job, null: false, foreign_key: true
      t.references :contact_person, null: false, foreign_key: { to_table: :recruiter_profiles }

      t.timestamps
    end

    add_index :job_contact_person_maps, [:job_id, :contact_person_id], unique: true
  end
end
