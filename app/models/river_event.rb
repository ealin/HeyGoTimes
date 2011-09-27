class RiverEvent < ActiveRecord::Base
  belongs_to :river
  belongs_to :news

  def self.get_river_event_by_id(river_id)
    find(:all, :conditions => {:river_id => river_id}, :order => 'created_at DESC')
  end
end
