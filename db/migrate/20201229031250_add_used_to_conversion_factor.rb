class AddUsedToConversionFactor < ActiveRecord::Migration[5.2]
  def change
    add_column :conversion_factors, :used, :boolean
  end
end
