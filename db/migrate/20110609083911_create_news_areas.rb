class CreateNewsAreas < ActiveRecord::Migration
  def self.up
    create_table :news_areas do |t|
      #
      # 因為在 news_tag.rb中已經定義 belongs_to : news, tag, 所以自動會產生foreign key ==> news_id, area_id
      #
      t.integer :news_id
      t.integer :area_id

    end
  end

  def self.down
    drop_table :news_areas
  end
end
