class User < ActiveRecord::Base
  has_many :news

  has_many :comments

  has_many :tag_filters
  has_many :tags, :through => :tag_filters

  has_many :area_filters
  has_many :areas, :through => :area_filters

  has_one :date_filter
  has_one :friend_filter

  has_many :user_likes
  has_many :likes, :through => :user_likes, :uniq => true, :class_name => "News", :source => :news

  has_many :user_dislikes
  has_many :dislikes, :through => :user_dislikes, :uniq => true, :class_name => "News", :source => :news

  has_many :user_watches
  has_many :watches, :through => :user_watches, :uniq => true, :class_name => "News", :source => :news

end
