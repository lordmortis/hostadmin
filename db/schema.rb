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

ActiveRecord::Schema.define(version: 2018_10_28_093155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "domain_users", id: false, force: :cascade do |t|
    t.uuid "domain_id", null: false
    t.uuid "user_id", null: false
    t.integer "permissions_store", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "domains", id: :uuid, default: nil, force: :cascade do |t|
    t.string "name", null: false
    t.integer "features_store", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", id: :uuid, default: nil, force: :cascade do |t|
    t.integer "authable_id"
    t.string "authable_type"
    t.string "device_name"
    t.boolean "http_only", null: false
    t.binary "secret", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authable_type", "authable_id"], name: "index_sessions_on_authable_type_and_authable_id"
  end

  create_table "users", id: :uuid, default: nil, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", null: false
    t.string "password_digest", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "domain_users", "domains"
  add_foreign_key "domain_users", "users"
end
