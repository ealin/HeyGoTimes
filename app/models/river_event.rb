class RiverEvent < ActiveRecord::Base
  belongs_to :river
  has_one :news
end
