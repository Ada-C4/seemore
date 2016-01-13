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

ActiveRecord::Schema.define(version: 20160113192912) do

  create_table "marks", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.string   "image_url"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "bio"
    t.string   "location"
    t.string   "link"
  end

  create_table "marks_spies", id: false, force: :cascade do |t|
    t.integer "mark_id"
    t.integer "spy_id"
  end

  add_index "marks_spies", ["mark_id"], name: "index_marks_spies_on_mark_id"
  add_index "marks_spies", ["spy_id"], name: "index_marks_spies_on_spy_id"

  create_table "media", force: :cascade do |t|
    t.integer  "mark_id"
    t.string   "media_url"
    t.string   "date_posted"
    t.string   "text"
    t.string   "location"
    t.string   "link"
    t.string   "medium_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "title"
    t.string   "uid"
    t.string   "retweet_status"
  end

  create_table "spies", force: :cascade do |t|
    t.string   "uid"
    t.string   "username"
    t.string   "image_url"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
