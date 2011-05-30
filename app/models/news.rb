class News < ActiveRecord::Base
  belongs_to :paper, :foreign_key => "paper_id"
  has_one :user
  has_one :area

  has_many :comments
  has_many :photos
  has_many :news_tags
end
