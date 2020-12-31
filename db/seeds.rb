MeasurementSystem.destroy_all
UnitType.destroy_all
Unit.destroy_all
ConversionFactor.destroy_all
MeasurementSystem.reset_pk_sequence
UnitType.reset_pk_sequence
Unit.reset_pk_sequence
ConversionFactor.reset_pk_sequence

########### Measurement Systems ####################
imperial = MeasurementSystem.create(name: "imperial")
metric = MeasurementSystem.create(name: "metric")

############## Unit Type ########################
distance = UnitType.create(name: "distance")

###### Units #######
i = Unit.create({unit: "in", initial_value: 0, measurement_system_id: 1, unit_type_id: 1, rank: 1})
ft = Unit.create({unit: "ft", initial_value: 0, measurement_system_id: 1, unit_type_id: 1, rank: 2})
yd = Unit.create({unit: "yd", initial_value: 0, measurement_system_id: 1, unit_type_id: 1, rank: 3})
mi = Unit.create({unit: "mi", initial_value: 0, measurement_system_id: 1, unit_type_id: 1, rank: 4})

mm = Unit.create({unit: "mm", initial_value: 0, measurement_system_id: 2, unit_type_id: 1, rank: 1})
cm = Unit.create({unit: "cm", initial_value: 0, measurement_system_id: 2, unit_type_id: 1, rank: 2})
dm = Unit.create({unit: "dm", initial_value: 0, measurement_system_id: 2, unit_type_id: 1, rank: 3})
m = Unit.create({unit: "m", initial_value: 0, measurement_system_id: 2, unit_type_id: 1, rank: 4})
dam = Unit.create({unit: "dam", initial_value: 0, measurement_system_id: 2, unit_type_id: 1, rank: 5})
hm = Unit.create({unit: "hm", initial_value: 0, measurement_system_id: 2, unit_type_id: 1, rank: 6})
km = Unit.create({unit: "km", initial_value: 0, measurement_system_id: 2, unit_type_id: 1, rank: 7})

#################       Create Imperial Conversions     #####################
ConversionFactor.create(unit1_id: i.id, unit1_value: 12.0, unit2_id: ft.id, unit2_value: 1, used: false)
ConversionFactor.create(unit1_id: ft.id, unit1_value: 3.0, unit2_id: yd.id, unit2_value: 1, used: false)
ConversionFactor.create(unit1_id: yd.id, unit1_value: 1760.0, unit2_id: mi.id, unit2_value: 1, used: false)
ConversionFactor.create(unit1_id: i.id, unit1_value: 1.0, unit2_id: cm.id, unit2_value: 2.54, used: false)

################      Create Metric Conversions       ##########################

metric_distance = ["mm","cm","dm","m","dam", "hm","km"]
$metric_units = [metric_distance]


def pick_metric_array(target_str)
  $metric_units.find { |unit_type_array| unit_type_array.include?(target_str)}
end

def power_of_10_difference (initial_unit_obj, target_str)
  metric_array = pick_metric_array(target_str)
  initial_index = metric_array.index(initial_unit_obj.unit)
  target_index = metric_array.index(target_str)
  power_of_10_difference = target_index - initial_index
end

def metric_conversion_ratios(initial_unit_obj, target_str)
  power = power_of_10_difference(initial_unit_obj, target_str)
  ratio = 10 ** power
end

def create_metric_conversion(initial_unit_obj,target_str)
  ratio = metric_conversion_ratios(initial_unit_obj, target_str)
  ConversionFactor.create(unit1_id: initial_unit_obj.id, unit1_value: 1, unit2_id: Unit.find_by(unit: target_str).id, unit2_value: ratio, used: false)
end

$metric_units.each do |unit_type_array|
  used_units = []
  unit_type_array.each do |unit_option|
    used_units << unit_option
    other_units = unit_type_array - used_units
    other_units.each do |other_unit|
      this_unit = Unit.find_by(unit: unit_option)
      create_metric_conversion(this_unit, other_unit)
    end
  end
end










puts "🔥 🔥 🔥 🔥 "