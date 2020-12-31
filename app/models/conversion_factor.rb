class ConversionFactor < ActiveRecord::Base 
  belongs_to :unit1, class_name: "Unit", foreign_key: :unit1_id
  belongs_to :unit2, class_name: "Unit", foreign_key: :unit2_id






end
