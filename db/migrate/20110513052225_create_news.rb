class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :title
      t.string :url
      t.string :area
      t.text :content

      t.integer :user_id
      t.integer :area_id
      t.integer :rank
      t.string :hard_copy

      #
      # 因為在 news.rb中已經定義 belongs_to : user, 所以自動會產生foreign key ==> user_id
      #
      t.string :news_id

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
