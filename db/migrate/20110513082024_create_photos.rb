class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :photo_id
      t.string :name
      t.string :url
      t.string :news_id

    end
  end

  def self.down
    drop_table :photos
  end
end
