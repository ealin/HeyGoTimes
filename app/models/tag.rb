class Tag < ActiveRecord::Base
  belongs_to :filter
  belongs_to :news_tag
end
