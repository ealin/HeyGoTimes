class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :news_id
      t.string :title
      t.string :url
      t.string :area
      t.string :tag
      t.text :content
      t.datetime :time
      t.integer :user_id
      t.integer :area_id
      t.integer :head_vote
      t.integer :suck_vote
      t.integer :rank
      t.string :hard_copy
    end
  end

  def self.down
    drop_table :news
  end
end
