class News < ActiveRecord::Base

  belongs_to :user

  has_one :area

  has_many :comments
  has_many :images

  has_many :news_tags
  has_many :tags, :through => :news_tags

  has_many :news_areas
  has_many :areas, :through => :news_areas

  has_many :user_likes
  has_many :likes, :through => :user_likes, :uniq => true, :class_name => "User", :source => :user

  has_many :user_dislikes
  has_many :dislikes, :through => :user_dislikes, :uniq => true, :class_name => "User", :source => :user

end
