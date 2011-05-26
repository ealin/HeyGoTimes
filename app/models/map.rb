class Map < ActiveRecord::Base
  belongs_to :area
  has_many :map_rects
end
