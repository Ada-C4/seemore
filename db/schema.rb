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

ActiveRecord::Schema.define(version: 20160110223715) do

  create_table "tweets", force: :cascade do |t|
    t.string   "twitter_id"
    t.string   "text"
    t.string   "uri"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "twitter_user_id"
  end

  add_index "tweets", ["twitter_user_id"], name: "index_tweets_on_twitter_user_id"

  create_table "twitter_users", force: :cascade do |t|
    t.string   "twitter_id"
    t.string   "screen_name"
    t.string   "name"
    t.string   "description"
    t.string   "location"
    t.string   "uri"
    t.string   "profile_image_uri"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "twitter_users_users", id: false, force: :cascade do |t|
    t.integer "twitter_user_id"
    t.integer "user_id"
  end

  add_index "twitter_users_users", ["twitter_user_id"], name: "index_twitter_users_users_on_twitter_user_id"
  add_index "twitter_users_users", ["user_id"], name: "index_twitter_users_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string   "uri"
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "vimeo_user_id"
    t.string   "vimeo_video_id"
  end

  add_index "videos", ["vimeo_user_id"], name: "index_videos_on_vimeo_user_id"

  create_table "vimeo_users", force: :cascade do |t|
    t.string   "description"
    t.string   "location"
    t.string   "uri"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "videos_uri"
    t.string   "name"
    t.string   "profile_images_uri"
  end

  create_table "vimeo_users_users", id: false, force: :cascade do |t|
    t.integer "vimeo_user_id"
    t.integer "user_id"
  end

  add_index "vimeo_users_users", ["user_id"], name: "index_vimeo_users_users_on_user_id"
  add_index "vimeo_users_users", ["vimeo_user_id"], name: "index_vimeo_users_users_on_vimeo_user_id"

end
