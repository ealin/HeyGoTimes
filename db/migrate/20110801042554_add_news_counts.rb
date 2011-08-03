class AddNewsCounts < ActiveRecord::Migration
  def self.up
    add_column :news, :watch_count, :integer, :default=>0
    add_column :news, :like_count, :integer, :default=>0
    add_column :news, :unlike_count, :integer, :default=>0
    add_column :news, :share_count, :integer, :default=>0
    add_column :news, :comment_count, :integer, :default=>0
  end

  def self.down
    remove_column :news, :watch_count
    remove_column :news, :like_count
    remove_column :news, :unlike_count
    remove_column :news, :share_count
    remove_column :news, :comment_count
  end
end
