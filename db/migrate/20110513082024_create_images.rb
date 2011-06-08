class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|

      t.string :name
      t.string :url

      #
      # 因為在 image.rb中已經定義 belongs_to : news, 所以自動會產生foreign key ==> news_id
      # 因為在 image.rb中已經定義 belongs_to : news, 所以自動會產生foreign key ==> news_id
      #
      t.integer :news_id

      t.timestamps

    end
  end

  def self.down
    drop_table :images
  end
end
