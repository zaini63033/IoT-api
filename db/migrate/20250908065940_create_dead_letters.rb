class CreateDeadLetters < ActiveRecord::Migration[8.0]
  def change
    create_table :dead_letters do |t|
      t.text :payload
      t.string :error
      t.string :topic
      t.integer :partition
      t.integer :offset

      t.timestamps
    end
  end
end
