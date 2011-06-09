class News < ActiveRecord::Base

  belongs_to :user

  has_one :area

  has_many :comments
  has_many :images

  has_many :news_tags
  has_many :tags, :through => :news_tags

  has_many :news_areas
  has_many :areas, :through => :news_areas


end
