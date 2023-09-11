class CreateApplicationStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :application_statuses do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
