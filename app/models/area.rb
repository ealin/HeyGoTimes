class Area < ActiveRecord::Base
  belongs_to :area_filter
  belongs_to :news, :foreign_key => "news_id"

end
