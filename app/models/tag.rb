class Tag < ActiveRecord::Base
  belongs_to :tag_filter

  belongs_to :news_tag
end
