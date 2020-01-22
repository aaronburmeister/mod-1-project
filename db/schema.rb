# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_22_230905) do

  create_table "activities", force: :cascade do |t|
    t.string "name"
  end

  create_table "destination_activities", force: :cascade do |t|
    t.integer "destination_id"
    t.integer "activity_id"
    t.index ["activity_id"], name: "index_destination_activities_on_activity_id"
    t.index ["destination_id"], name: "index_destination_activities_on_destination_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "main_menu_options", force: :cascade do |t|
    t.string "option_name"
    t.boolean "active"
  end

end
