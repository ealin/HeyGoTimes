class CreateUserNewsRanks < ActiveRecord::Migration
  def self.up
    create_table :user_news_ranks do |t|
      t.integer :user_id
      t.integer :news_id
      t.integer :rank
      t.boolean :my_news

      t.timestamps
    end
  end

  def self.down
    drop_table :user_news_ranks
  end
end
