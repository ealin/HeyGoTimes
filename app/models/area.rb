class Area < ActiveRecord::Base

  has_many :area_filters
  has_many :users, :through => :area_filters


  has_many :news_areas
  has_many :news, :through => :news_areas

end
