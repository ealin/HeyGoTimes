class CreateUserUnlikes < ActiveRecord::Migration
  def self.up
    create_table :user_unlikes do |t|
      t.integer :user_id
      t.integer :news_id
    end
  end

  def self.down
    drop_table :user_unlikes
  end
end
