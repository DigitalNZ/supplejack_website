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

ActiveRecord::Schema.define(version: 20151005091559) do

  create_table "api_keys", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "terms",      default: true
  end

  create_table "communities", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "kete_slug"
    t.text     "description"
    t.string   "feature_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "communities", ["slug"], name: "index_communities_on_slug", using: :btree

  create_table "communities_contributed_items", id: false, force: true do |t|
    t.integer "community_id",        null: false
    t.integer "contributed_item_id", null: false
  end

  create_table "communities_stories", id: false, force: true do |t|
    t.integer "community_id", null: false
    t.integer "story_id",     null: false
  end

  create_table "communities_users", id: false, force: true do |t|
    t.integer "community_id", null: false
    t.integer "user_id",      null: false
  end

  create_table "contributed_items", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.string   "status"
    t.text     "description"
    t.date     "date_of_item"
    t.string   "creator"
    t.string   "copyright"
    t.string   "item_path"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributed_items", ["category"], name: "index_contributed_items_on_category", using: :btree
  add_index "contributed_items", ["item_path"], name: "index_contributed_items_on_item_path", using: :btree
  add_index "contributed_items", ["user_id"], name: "index_contributed_items_on_user_id", using: :btree

  create_table "records", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.string   "user_set_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["user_set_id"], name: "index_stories_on_user_set_id", using: :btree

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
