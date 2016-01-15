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

ActiveRecord::Schema.define(version: 20160113224340) do

  create_table "categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "creator_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["creator_id"], name: "index_categories_on_creator_id"
  add_index "categories", ["user_id"], name: "index_categories_on_user_id"

  create_table "creators", force: :cascade do |t|
    t.string   "name"
    t.string   "profile_pic"
    t.string   "description"
    t.string   "provider"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "uri"
    t.string   "uid"
  end

  create_table "tweets", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "posted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uid"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "provider"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "avatar_url"
  end

  create_table "videos", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "posted_at"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "uri"
    t.string   "name"
    t.string   "embed"
    t.string   "description"
    t.string   "vimeo_id"
  end

end
