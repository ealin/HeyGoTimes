class News < ActiveRecord::Base

  belongs_to :user

  has_one :area

  has_many :comments
  has_many :photos

  has_many :news_tags
  has_many :tags, :through => :news_tags

end
