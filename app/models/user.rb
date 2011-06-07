class User < ActiveRecord::Base
  has_many :news

  has_many :comments

  has_many :tag_filters
  has_many :tags, :through => :tag_filters

  has_many :area_filters
  has_many :areas, :through => :area_filters

  has_one :date_filter
  has_one :friend_filter

end
