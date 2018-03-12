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

ActiveRecord::Schema.define(version: 20180310200936) do

  create_table "calendars", force: :cascade do |t|
    t.string "name"
    t.string "last_frost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crops", force: :cascade do |t|
    t.string "name"
    t.string "start_date"
    t.boolean "transplant"
    t.string "transplant_date"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "days_to_maturity"
    t.integer "start_offset", default: 0
    t.integer "transplant_offset", default: 0
    t.text "notes"
    t.string "image", default: ""
    t.index ["location_id"], name: "index_crops_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "calendar_id"
    t.boolean "auto_water"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image", default: ""
    t.index ["calendar_id"], name: "index_locations_on_calendar_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "crop_id"
    t.string "year"
    t.string "start_date"
    t.string "transplant_date"
    t.boolean "transplant"
    t.string "harvest_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crop_id", "year"], name: "index_seasons_on_crop_id_and_year", unique: true
    t.index ["crop_id"], name: "index_seasons_on_crop_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.datetime "last_login"
    t.string "password_hash"
    t.string "password_salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "is_admin", default: 0
  end

end
