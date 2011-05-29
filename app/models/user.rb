class User < ActiveRecord::Base
  belongs_to :news

  has_many :tag_filters
  has_many :area_filters
  has_many :date_filters
  has_many :friend_filters

end
