class CreateJobStatusMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :job_status_maps do |t|
      t.references  :job,  index: true, foreign_key: true
      t.references  :job_status, index: true, foreign_key: true
      t.timestamps
    end
  end
end
