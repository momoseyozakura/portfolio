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

ActiveRecord::Schema.define(version: 2023_02_07_091725) do
  create_table "messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "talk_room_id", null: false
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["talk_room_id"], name: "index_messages_on_talk_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "room_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "talk_room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["talk_room_id"], name: "index_room_users_on_talk_room_id"
    t.index ["user_id"], name: "index_room_users_on_user_id"
  end

  create_table "studio_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "studio_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "lottely"
    t.index ["studio_id"], name: "index_studio_users_on_studio_id"
    t.index ["user_id"], name: "index_studio_users_on_user_id"
  end

  create_table "studios", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "talk_rooms", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "image"
    t.text "member"
    t.boolean "admin", default: false
    t.boolean "open", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "messages", "talk_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "room_users", "talk_rooms"
  add_foreign_key "room_users", "users"
  add_foreign_key "studio_users", "studios"
  add_foreign_key "studio_users", "users"
end
