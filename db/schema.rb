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

ActiveRecord::Schema.define(version: 20181014070827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.integer "count"
    t.index ["event_id"], name: "index_bookings_on_event_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.string "category", null: false
    t.geography "location", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.boolean "hidden", default: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.decimal "cost"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organizer_id"
    t.integer "available_places"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp"
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "encrypted_password", null: false
    t.string "phone", null: false
    t.string "name", null: false
    t.string "country_code", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_code", "phone"], name: "index_users_on_country_code_and_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "users", column: "organizer_id"
end
