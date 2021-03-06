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

ActiveRecord::Schema.define(version: 20140607180440) do

  create_table "assignments", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name",                         null: false
    t.text     "description",                  null: false
    t.integer  "studio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "address_line1",                null: false
    t.text     "address_line2"
    t.text     "city",                         null: false
    t.text     "state",                        null: false
    t.float    "lat"
    t.float    "lng"
    t.integer  "is_location_set", default: -1
    t.string   "zip_code"
    t.string   "photo_path",      default: ""
    t.date     "event_date"
    t.time     "event_time"
  end

  create_table "experiencelinks", force: true do |t|
    t.integer  "collab_id"
    t.string   "collab_type"
    t.integer  "experience_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "collab_name",   default: ""
  end

  create_table "experiences", force: true do |t|
    t.string   "content",    default: "", null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "member_id"
    t.integer  "studio_id"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studios", force: true do |t|
    t.string   "name",                         null: false
    t.text     "description",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fb_url"
    t.string   "ig_url"
    t.string   "website_url"
    t.string   "email"
    t.string   "phone_area_code", default: ""
    t.string   "phone_1",         default: ""
    t.string   "phone_2",         default: ""
    t.float    "lat"
    t.float    "lng"
    t.integer  "is_location_set", default: -1
    t.string   "zip_code"
    t.text     "address_line1",                null: false
    t.text     "address_line2"
    t.text     "city",                         null: false
    t.text     "state",                        null: false
    t.string   "yt_username",     default: ""
    t.string   "twtr_username",   default: ""
    t.string   "photo_path",      default: ""
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "blurb"
    t.string   "city"
    t.string   "state"
    t.string   "title"
    t.string   "fb_url",                 default: ""
    t.string   "twtr_url",               default: ""
    t.string   "yt_url",                 default: ""
    t.string   "ig_url",                 default: ""
    t.string   "website_url"
    t.string   "phone_area_code",        default: ""
    t.string   "phone_1",                default: ""
    t.string   "phone_2",                default: ""
    t.string   "photo_path",             default: ""
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videochats", force: true do |t|
    t.string   "title",        null: false
    t.string   "host_peer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.string   "youtube_id",  null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "youtube_url"
  end

end
