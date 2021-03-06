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

ActiveRecord::Schema.define(version: 2020_06_25_182324) do

  create_table "disliked_entries", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_entry_id"
  end

  create_table "feed_entries", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "published"
    t.datetime "updated"
    t.string "entry_id"
    t.integer "feed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "feed_url"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feeds_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_id"
  end

  create_table "liked_entries", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_entry_id"
  end

  create_table "read_entries", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "feed_entry_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
