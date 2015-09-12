# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150826135352) do

  create_table "comments", force: :cascade do |t|
    t.boolean  "like"
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "dislike",    default: false
  end

  add_index "comments", ["message_id"], name: "index_comments_on_message_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.string   "message_type"
    t.text     "content"
    t.float    "longitude"
    t.float    "latitude"
    t.decimal  "hold_time",    precision: 16
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "user_name"
    t.integer  "message_id"
    t.integer  "user_id"
    t.string   "image"
    t.integer  "race_num"
    t.integer  "start_id"
    t.integer  "like_num",                    default: 0
    t.integer  "dislike_num",                 default: 0
  end

  add_index "messages", ["message_id"], name: "index_messages_on_message_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "user_name"
    t.datetime "logout_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  add_index "users", ["user_id"], name: "index_users_on_user_id"

end
