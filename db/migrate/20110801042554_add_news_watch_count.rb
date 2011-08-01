class AddNewsWatchCount < ActiveRecord::Migration
  def self.up
    add_column :news, :watch_count, :integer, :default=>0
  end

  def self.down
    remove_column :news, :watch_count
  end
end
