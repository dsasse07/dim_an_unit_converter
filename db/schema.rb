# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_29_031250) do

  create_table "conversion_factors", force: :cascade do |t|
    t.integer "unit1_id"
    t.float "unit1_value"
    t.integer "unit2_id"
    t.float "unit2_value"
    t.boolean "used"
  end

  create_table "measurement_systems", force: :cascade do |t|
    t.string "name"
  end

  create_table "unit_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "units", force: :cascade do |t|
    t.string "unit"
    t.integer "initial_value"
    t.integer "measurement_system_id"
    t.integer "unit_type_id"
    t.integer "rank"
  end

end
