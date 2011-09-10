class River < ActiveRecord::Base
  belongs_to :user
  has_many :river_events
  has_many :notes
  has_many :followed, :through => :follows
end
