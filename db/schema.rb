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

ActiveRecord::Schema.define(version: 2021_11_16_030008) do

  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_participants_on_room_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "is_private", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "lat", default: 0.0
    t.float "long", default: 0.0
    t.float "distance", default: 0.0
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "lat", default: 0.0
    t.float "long", default: 0.0
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
    t.string "name"
  end

  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "participants", "rooms"
  add_foreign_key "participants", "users"
end
