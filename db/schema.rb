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

ActiveRecord::Schema.define(version: 20140208104429) do

  create_table "quests", force: true do |t|
    t.string   "title"
    t.string   "photo_url"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "extra_credit_description"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "self_reviewable"
    t.integer  "self_review_range"
  end

  add_index "quests", ["latitude"], name: "index_quests_on_latitude"
  add_index "quests", ["longitude"], name: "index_quests_on_longitude"

  create_table "submissions", force: true do |t|
    t.integer  "user_id"
    t.integer  "quest_id"
    t.boolean  "has_extra_credit"
    t.integer  "status"
    t.datetime "submitted_at"
    t.integer  "ranking"
    t.integer  "difficulty"
    t.integer  "xp"
    t.integer  "coins_earned"
    t.integer  "extra_credit_coins_earned"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
    t.integer  "facebook_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token"
  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id"

end
