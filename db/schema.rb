# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_29_215332) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "log_entries", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "cost"
    t.integer "recorded_mileage"
    t.date "performed_on"
    t.bigint "vehicle_id", null: false
    t.boolean "has_paper_record", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_log_entries_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vin", null: false
    t.string "make"
    t.string "model"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vin"], name: "index_vehicles_on_vin", unique: true
  end

  add_foreign_key "log_entries", "vehicles"
end
