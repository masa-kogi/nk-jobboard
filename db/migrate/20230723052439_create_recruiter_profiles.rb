class CreateRecruiterProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :recruiter_profiles do |t|
      t.references :recruiter, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false

      t.timestamps
    end
  end
end
