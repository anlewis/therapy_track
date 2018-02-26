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

ActiveRecord::Schema.define(version: 20180226202823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "google_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "access_token"
    t.string "token_type"
    t.integer "expires_in"
    t.string "refresh_token"
    t.index ["user_id"], name: "index_google_auths_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "calendar"
  end

  add_foreign_key "google_auths", "users"
end
