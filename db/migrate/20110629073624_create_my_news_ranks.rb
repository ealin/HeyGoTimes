class CreateMyNewsRanks < ActiveRecord::Migration
  def self.up
    create_table :my_news_ranks do |t|
      t.integer :user_id
      t.integer :news_id
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :my_news_ranks
  end
end
