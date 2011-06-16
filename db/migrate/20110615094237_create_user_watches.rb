class CreateUserWatches < ActiveRecord::Migration
  def self.up
    create_table :user_watches do |t|
      t.integer :user_id
      t.integer :news_id
    end
  end

  def self.down
    drop_table :user_watches
  end
end
