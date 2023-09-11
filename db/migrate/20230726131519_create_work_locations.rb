class CreateWorkLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :work_locations do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
