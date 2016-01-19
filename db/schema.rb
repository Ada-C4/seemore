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

ActiveRecord::Schema.define(version: 20160111231950) do

  create_table "handles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "uri"
    t.string   "profile_image_uri"
    t.string   "provider"
    t.string   "link"
  end

  create_table "handles_users", id: false, force: :cascade do |t|
    t.integer "handle_id"
    t.integer "user_id"
  end

  add_index "handles_users", ["handle_id"], name: "index_handles_users_on_handle_id"
  add_index "handles_users", ["user_id"], name: "index_handles_users_on_user_id"

  create_table "identities", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "media", force: :cascade do |t|
    t.integer  "handle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uri"
    t.string   "embed"
    t.datetime "posted_at"
  end

  add_index "media", ["handle_id"], name: "index_media_on_handle_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
