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

  create_table "ad_grids", :force => true do |t|
    t.string   "ad_id"
    t.string   "paper_id"
    t.integer  "user_id"
    t.string   "url_link"
    t.string   "image"
    t.integer  "page"
    t.integer  "row"
    t.integer  "column"
    t.integer  "fee"
    t.datetime "issued_tate"
    t.integer  "public_days"
    t.datetime "valid_through"
  end

  create_table "area_filters", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.string   "area_id"
    t.string   "name"
    t.string   "parent_area_id"
    t.integer  "level"
    t.string   "latitude"
    t.string   "longtitude"
    t.string   "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "comment_id"
    t.string   "news_id"
    t.integer  "user_id"
    t.text     "comment"
    t.integer  "head_vote"
    t.integer  "suck_vote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "date_filters", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filters", :force => true do |t|
    t.integer  "subscription_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friend_filters", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "news_id"
    t.string   "title"
    t.string   "url"
    t.string   "area"
    t.string   "tag"
    t.text     "content"
    t.datetime "time"
    t.integer  "user_id"
    t.integer  "area_id"
    t.integer  "head_vote"
    t.integer  "suck_vote"
    t.integer  "rank"
    t.string   "hard_copy"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.text     "description"
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
