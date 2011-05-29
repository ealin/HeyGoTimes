class CreateFriendFilters < ActiveRecord::Migration
  def self.up
    create_table :friend_filters do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :friend_filters
  end
end
