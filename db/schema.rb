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

ActiveRecord::Schema.define(version: 20150801030724) do

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows"

  create_table "inode_activities", force: :cascade do |t|
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "inode_id"
  end

  add_index "inode_activities", ["inode_id"], name: "index_inode_activities_on_inode_id"

  create_table "inodes", force: :cascade do |t|
    t.string   "name"
    t.string   "inode_type"
    t.string   "content"
    t.string   "content_type"
    t.integer  "file_size"
    t.string   "ancestry"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "inodes", ["ancestry"], name: "index_inodes_on_ancestry"

  create_table "shares", force: :cascade do |t|
    t.string   "access_token", null: false
    t.string   "email",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "inode_id"
  end

  add_index "shares", ["inode_id"], name: "index_shares_on_inode_id"

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "inode_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["inode_id"], name: "index_users_on_inode_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
