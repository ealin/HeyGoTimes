class CreateUserLikes < ActiveRecord::Migration
  def self.up
    create_table :user_likes do |t|
      t.integer :user_id
      t.integer :news_id
    end
  end

  def self.down
    drop_table :user_likes
  end
end
