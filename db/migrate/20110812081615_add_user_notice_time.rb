class AddUserNoticeTime < ActiveRecord::Migration
  def self.up
    add_column :users, :last_event_notification, :datetime
    add_column :users, :last_sys_notification, :datetime
  end

  def self.down
    remove_column :users, :last_event_notification
    remove_column :users, :last_sys_notification
  end
end
