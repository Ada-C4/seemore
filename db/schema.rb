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

ActiveRecord::Schema.define(version: 20160114171839) do

  create_table "contents", force: :cascade do |t|
    t.string   "content_id"
    t.string   "text"
    t.string   "create_time"
    t.integer  "favorites"
    t.string   "embed_code"
    t.integer  "retweet_count"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "creator_id"
    t.string   "provider"
  end

  add_index "contents", ["creator_id"], name: "index_contents_on_creator_id"

  create_table "creators", force: :cascade do |t|
    t.string   "p_id"
    t.string   "provider"
    t.string   "avatar_url"
    t.string   "username"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "last_updated"
  end

  create_table "creators_users", id: false, force: :cascade do |t|
    t.integer "creator_id"
    t.integer "user_id"
  end

  add_index "creators_users", ["creator_id"], name: "index_creators_users_on_creator_id"
  add_index "creators_users", ["user_id"], name: "index_creators_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_creators", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "creator_id"
  end

  add_index "users_creators", ["creator_id"], name: "index_users_creators_on_creator_id"
  add_index "users_creators", ["user_id"], name: "index_users_creators_on_user_id"

end
