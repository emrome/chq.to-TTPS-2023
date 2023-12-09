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

ActiveRecord::Schema[7.1].define(version: 2023_12_07_143005) do
  create_table "access_logs", force: :cascade do |t|
    t.string "ip_address", null: false
    t.date "access_date", null: false
    t.integer "link_id", null: false
    t.index ["ip_address", "access_date"], name: "index_access_logs_on_ip_address_and_access_date", unique: true
    t.index ["link_id", "access_date"], name: "index_access_logs_on_link_id_and_access_date"
    t.index ["link_id"], name: "index_access_logs_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "url", null: false
    t.string "slug", null: false
    t.string "name"
    t.integer "user_id", null: false
    t.string "type"
    t.string "password"
    t.date "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_links_on_slug", unique: true
    t.index ["url"], name: "index_links_on_url"
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "access_logs", "links"
  add_foreign_key "links", "users"
end
