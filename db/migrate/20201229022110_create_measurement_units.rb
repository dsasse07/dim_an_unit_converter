class CreateMeasurementUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :measurement_systems do |t|
      t.string :name
    end
  end
end
