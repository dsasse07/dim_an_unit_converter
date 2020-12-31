class RenameColumnUnit2ToUnit2Id < ActiveRecord::Migration[5.2]
  def change
    rename_column :conversion_factors, :unit2, :unit2_id
  end
end
