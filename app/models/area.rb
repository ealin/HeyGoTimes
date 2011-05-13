class Area < ActiveRecord::Base
  has_one :map
  has_one :area
  belongs_to :area, :foreign_key => "area_id"
  belongs_to :paper, :foreign_key => "paper_id"
  belongs_to :news, :foreign_key => "news_id"
end
