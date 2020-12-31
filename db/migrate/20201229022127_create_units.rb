class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.string :unit
      t.integer :initial_value
      t.integer :measurement_system
      t.integer :unit_type_id
      t.integer :rank
    end
  end
end
