class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      #
      # 因為在 area.rb中已經定義 belongs_to : news, 所以自動會產生foreign key ==> news_id
      #
      t.integer :news_id

      t.string :name
      t.string :primary_tag


      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
