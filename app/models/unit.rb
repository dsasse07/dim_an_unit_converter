class Unit < ActiveRecord::Base
  belongs_to :measurement_system
  belongs_to :unit_type
  has_many :conversion_factors, foreign_key: :unit1_id

end
