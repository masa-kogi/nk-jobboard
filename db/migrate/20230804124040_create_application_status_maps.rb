class CreateApplicationStatusMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :application_status_maps do |t|
      t.references :job_application, null: false, foreign_key: true
      t.references :application_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
