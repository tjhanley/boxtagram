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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121224003501) do

  create_table "users", :force => true do |t|
    t.integer  "instagram_id"
    t.string   "username"
    t.string   "full_name"
    t.string   "profile_picture"
    t.string   "instagram_access_token"
    t.string   "dropbox_access_token"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "dropbox_secret_token"
    t.boolean  "has_migrated",           :default => false
    t.string   "email"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["instagram_id"], :name => "index_users_on_instagram_id", :unique => true

end
