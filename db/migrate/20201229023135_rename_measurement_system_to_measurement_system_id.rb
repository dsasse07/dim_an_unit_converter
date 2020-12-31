class RenameMeasurementSystemToMeasurementSystemId < ActiveRecord::Migration[5.2]
  def change
    rename_column :units, :measurement_system, :measurement_system_id
  end
end
