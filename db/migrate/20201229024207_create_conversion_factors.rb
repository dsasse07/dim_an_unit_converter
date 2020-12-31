class CreateConversionFactors < ActiveRecord::Migration[5.2]
  def change
    create_table :conversion_factors do |t|
      t.integer :unit1_id
      t.float :unit1_value
      t.integer :unit2
      t.float :unit2_value
    end
  end
end
