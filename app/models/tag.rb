class Tag < ActiveRecord::Base

  has_many :tag_filters
  has_many :users, :through => :tag_filters

  has_many :news_tags
  has_many :news, :through => :news_tags

end
