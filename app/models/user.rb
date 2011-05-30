class User < ActiveRecord::Base
  belongs_to :news

  has_many :comments

  has_many :tag_filters
  has_many :area_filters
  has_one :date_filters
  has_many :friend_filters

end
