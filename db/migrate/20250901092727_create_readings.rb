class CreateReadings < ActiveRecord::Migration[8.0]
  def change
    create_table :readings do |t|
      t.string :device_id
      t.string :reading_id
      t.jsonb :metrics
      t.string :ts

      t.timestamps
    end
  end
end
