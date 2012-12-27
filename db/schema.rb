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

ActiveRecord::Schema.define(:version => 20121226121610) do

  create_table "aocs", :force => true do |t|
    t.string   "en_name"
    t.string   "cn_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "beers", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "beverages", :force => true do |t|
    t.string   "type"
    t.string   "en_title"
    t.string   "cn_title"
    t.float    "alcohol"
    t.integer  "volume"
    t.string   "flavor"
    t.string   "color"
    t.string   "distillation_method"
    t.string   "barrel_cask"
    t.string   "style"
    t.string   "sub_style"
    t.integer  "age"
    t.text     "pic_url"
    t.integer  "region_id"
    t.integer  "brand_id"
    t.integer  "rank_id"
    t.integer  "aoc_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "en_name"
    t.string   "cn_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "containers", :force => true do |t|
    t.integer  "beverage_id"
    t.integer  "cup_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "containers", ["beverage_id", "cup_id"], :name => "index_containers_on_beverage_id_and_cup_id"
  add_index "containers", ["cup_id", "beverage_id"], :name => "index_containers_on_cup_id_and_beverage_id"

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cups", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "grapes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ranks", :force => true do |t|
    t.string   "en_name"
    t.string   "cn_name"
    t.string   "category"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "en_name"
    t.string   "cn_name"
    t.string   "ancestry"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "regions", ["ancestry"], :name => "index_regions_on_ancestry"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "nick"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "role",                   :default => 1
    t.string   "bio"
    t.string   "avatar"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "vinifications", :force => true do |t|
    t.integer  "beverage_id"
    t.integer  "grape_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "vinifications", ["beverage_id", "grape_id"], :name => "index_vinifications_on_beverage_id_and_grape_id"
  add_index "vinifications", ["grape_id", "beverage_id"], :name => "index_vinifications_on_grape_id_and_beverage_id"

  create_table "whiskies", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "wines", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
