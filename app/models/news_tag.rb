class NewsTag < ActiveRecord::Base
  belongs_to :news
  has_many :tags
end
