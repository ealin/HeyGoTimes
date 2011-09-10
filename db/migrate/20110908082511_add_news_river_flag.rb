class AddNewsRiverFlag < ActiveRecord::Migration
  def self.up
    add_column :news, :river_event, :boolean, :default=>false
    add_column :news, :daily_news, :boolean, :default=>false
  end

  def self.down
    remove_column :river_event
    remove_column :daily_news
  end
end
