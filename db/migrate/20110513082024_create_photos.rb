class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|

      t.string :photo_id
      t.string :name
      t.string :url


      #
      # 因為在 photo.rb中已經定義 belongs_to : news, 所以自動會產生foreign key ==> news_id
      #
      t.string :news_id

    end
  end

  def self.down
    drop_table :photos
  end
end
