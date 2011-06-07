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

ActiveRecord::Schema.define(:version => 20110529165224) do

  create_table "area_filters", :force => true do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.integer  "news_id"
    t.string   "name"
    t.string   "primary_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "news_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "date_filters", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.string   "option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friend_filters", :force => true do |t|
    t.integer "user_id"
    t.string  "type"
  end

  create_table "news", :force => true do |t|
    t.string   "news_id"
    t.string   "title"
    t.string   "url"
    t.string   "area"
    t.text     "content"
    t.integer  "area_id"
    t.integer  "rank"
    t.string   "hard_copy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_tags", :force => true do |t|
    t.string  "news_id"
    t.integer "tag_id"
  end

  create_table "photos", :force => true do |t|
    t.string "photo_id"
    t.string "name"
    t.string "url"
    t.string "news_id"
  end

  create_table "tag_filters", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "parent_tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "locale"
    t.datetime "birthday"
    t.string   "host_account"
    t.integer  "host_id"
    t.integer  "host_site"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
