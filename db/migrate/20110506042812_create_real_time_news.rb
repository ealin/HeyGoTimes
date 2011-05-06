class CreateRealTimeNews < ActiveRecord::Migration
  def self.up
    create_table :real_time_news do |t|
      t.string :title
      t.string :url
      t.string :area
      t.string :tag
      t.text :content
      t.datetime :time

      t.timestamps
    end
  end

  def self.down
    drop_table :real_time_news
  end
end
