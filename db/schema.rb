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

ActiveRecord::Schema.define(:version => 20130118034043) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activity_feeds", :force => true do |t|
    t.string   "type"
    t.text     "data"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "areas", :id => false, :force => true do |t|
    t.integer  "code"
    t.string   "name"
    t.string   "ancestry"
    t.integer  "city_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "areas", ["ancestry"], :name => "index_areas_on_ancestry"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "released_at"
    t.integer  "view_count"
    t.integer  "author_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "beverages", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "trans"
    t.string   "alcohol"
    t.string   "volume"
    t.string   "bottler"
    t.string   "distillation_method"
    t.string   "barrel_cask"
    t.string   "style"
    t.string   "color"
    t.string   "sweetness"
    t.string   "vintage"
    t.string   "age"
    t.string   "picture"
    t.text     "pic_url"
    t.string   "grape_list"
    t.integer  "region_id"
    t.integer  "brand_id"
    t.integer  "rank_id"
    t.integer  "author_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "trans"
    t.string   "description"
    t.string   "picture"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "checks", :force => true do |t|
    t.string   "remark"
    t.integer  "author_id"
    t.integer  "beverage_id"
    t.integer  "star"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cities", :id => false, :force => true do |t|
    t.integer  "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cocktails", :force => true do |t|
    t.string   "name"
    t.string   "trans"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.string   "ancestry"
    t.integer  "author_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"

  create_table "complains", :force => true do |t|
    t.string   "remark"
    t.boolean  "is_ignored",        :default => false
    t.boolean  "is_solved",         :default => false
    t.integer  "author_id"
    t.integer  "complainable_id"
    t.string   "complainable_type"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "complains", ["complainable_id", "complainable_type"], :name => "index_complains_on_complainable_id_and_complainable_type"

  create_table "containers", :force => true do |t|
    t.integer  "beverage_id"
    t.integer  "cup_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "containers", ["beverage_id", "cup_id"], :name => "index_containers_on_beverage_id_and_cup_id"
  add_index "containers", ["cup_id", "beverage_id"], :name => "index_containers_on_cup_id_and_beverage_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "cups", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deals", :force => true do |t|
    t.integer  "amount"
    t.float    "price"
    t.string   "remark"
    t.integer  "beverage_id"
    t.integer  "seller_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.string   "amount"
    t.integer  "recipe_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lists", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "author_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "lists", ["author_id"], :name => "index_lists_on_author_id"

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "city_id"
    t.integer  "area_id"
    t.integer  "locationable_id"
    t.string   "locationable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "locations", ["locationable_id", "locationable_type"], :name => "index_locations_on_locationable_id_and_locationable_type"

  create_table "merchants", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "nodes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.string   "notification_code"
    t.string   "attachment"
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "packages", :force => true do |t|
    t.integer  "list_id"
    t.integer  "beverage_id"
    t.string   "remark"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "packages", ["beverage_id", "list_id"], :name => "index_packages_on_beverage_id_and_list_id"
  add_index "packages", ["list_id", "beverage_id"], :name => "index_packages_on_list_id_and_beverage_id"

  create_table "pieces", :force => true do |t|
    t.string   "flavor"
    t.integer  "strength"
    t.integer  "review_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.float    "price"
    t.integer  "currency"
    t.string   "source"
    t.string   "source_id"
    t.text     "source_url"
    t.integer  "beverage_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ranks", :force => true do |t|
    t.string   "name"
    t.string   "trans"
    t.string   "type_list"
    t.string   "ancestry"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "recipes", :force => true do |t|
    t.string   "name"
    t.string   "remark"
    t.string   "picture"
    t.text     "pic_url"
    t.integer  "cocktail_id"
    t.integer  "author_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "redactor_assets", :force => true do |t|
    t.integer  "user_id"
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "redactor_assets", ["assetable_type", "assetable_id"], :name => "idx_redactor_assetable"
  add_index "redactor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_redactor_assetable_type"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "trans"
    t.string   "ancestry"
    t.string   "beverage_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "regions", ["ancestry"], :name => "index_regions_on_ancestry"

  create_table "replies", :force => true do |t|
    t.text     "body"
    t.integer  "topic_id"
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "score"
    t.integer  "nose_score"
    t.string   "nose_list"
    t.integer  "taste_score"
    t.string   "taste_list"
    t.integer  "finish_score"
    t.string   "finish_list"
    t.integer  "balance_score"
    t.string   "balance_list"
    t.string   "food_list"
    t.integer  "up_votes",      :default => 0, :null => false
    t.integer  "down_votes",    :default => 0, :null => false
    t.integer  "author_id"
    t.integer  "beverage_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "scores", :force => true do |t|
    t.string   "type"
    t.string   "points"
    t.integer  "review_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "topics", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "replied_at"
    t.integer  "replies_count",    :default => 0
    t.integer  "last_active_mark"
    t.integer  "last_reply_id"
    t.integer  "author_id"
    t.integer  "node_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "nick"
    t.string   "avatar"
    t.string   "role"
    t.text     "bio"
    t.string   "locked_nodes_list"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vinifications", :force => true do |t|
    t.integer  "beverage_id"
    t.integer  "grape_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "vinifications", ["beverage_id", "grape_id"], :name => "index_vinifications_on_beverage_id_and_grape_id"
  add_index "vinifications", ["grape_id", "beverage_id"], :name => "index_vinifications_on_grape_id_and_beverage_id"

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

  create_table "wishes", :force => true do |t|
    t.string   "remark"
    t.boolean  "accomplished", :default => false
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "beverage_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_foreign_key "notifications", "conversations", :name => "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", :name => "receipts_on_notification_id"

end
