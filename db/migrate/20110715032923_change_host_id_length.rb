class ChangeHostIdLength < ActiveRecord::Migration
  def self.up
    change_column :users, :host_id, :limit => 8
  end

  def self.down
  end
end
