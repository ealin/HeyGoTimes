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

ActiveRecord::Schema.define(:version => 20110928062259) do

  create_table "area_filters", :force => true do |t|
    t.integer  "user_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.string   "parent_area"
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

  create_table "follows", :force => true do |t|
    t.integer "user_id"
    t.integer "river_id"
    t.integer "position"
  end

  create_table "friend_filters", :force => true do |t|
    t.integer "user_id"
    t.string  "friend_filter_type"
  end

  create_table "friendships", :force => true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "news_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "area_string"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "rank",          :default => 0
    t.string   "fb_obj_url"
    t.boolean  "special_flag",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "watch_count",   :default => 0
    t.integer  "like_count",    :default => 0
    t.integer  "unlike_count",  :default => 0
    t.integer  "share_count",   :default => 0
    t.integer  "comment_count", :default => 0
    t.boolean  "river_event",   :default => false
    t.boolean  "daily_news",    :default => false
  end

  create_table "news_areas", :force => true do |t|
    t.integer "news_id"
    t.integer "area_id"
  end

  create_table "news_tags", :force => true do |t|
    t.integer "news_id"
    t.integer "tag_id"
  end

  create_table "notes", :force => true do |t|
    t.integer  "river_id"
    t.text     "content"
    t.datetime "note_dt"
    t.string   "comment_url"
  end

  create_table "river_events", :force => true do |t|
    t.integer  "news_id"
    t.integer  "river_id"
    t.datetime "event_dt"
  end

  create_table "rivers", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "location"
    t.string   "url"
    t.integer  "position"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "img"
  end

  create_table "system_datas", :force => true do |t|
    t.datetime "last_system_notice",       :default => '2011-08-31 06:43:31'
    t.datetime "last_news_rank_reduction", :default => '2011-08-31 06:43:31'
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

  create_table "user_likes", :force => true do |t|
    t.integer "user_id"
    t.integer "news_id"
  end

  create_table "user_news_ranks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "news_id"
    t.integer  "rank",       :default => 0
    t.boolean  "my_news"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_unlikes", :force => true do |t|
    t.integer "user_id"
    t.integer "news_id"
  end

  create_table "user_watches", :force => true do |t|
    t.integer "user_id"
    t.integer "news_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "locale"
    t.datetime "birthday"
    t.string   "host_account"
    t.integer  "host_id",                 :limit => 8
    t.integer  "host_site"
    t.boolean  "admin",                                :default => false
    t.date     "last_update_friends"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_event_notification"
    t.datetime "last_sys_notification"
  end

end
