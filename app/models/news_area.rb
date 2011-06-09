class NewsArea < ActiveRecord::Base
  belongs_to :news
  belongs_to :area
end
