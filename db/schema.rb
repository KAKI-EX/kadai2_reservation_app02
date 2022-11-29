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

ActiveRecord::Schema.define(version: 2022_11_29_085431) do

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "room_name", null: false
    t.integer "room_price", null: false
    t.text "room_info"
    t.integer "room_address_postcode", null: false
    t.string "room_address_prefecture", null: false
    t.string "room_address_town_village", null: false
    t.string "room_address_other"
    t.string "room_photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "check_in", null: false
    t.datetime "check_out", null: false
    t.integer "stay_count", null: false
    t.integer "peaple_count", null: false
    t.integer "room_fee", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_fee", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "avatar", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
