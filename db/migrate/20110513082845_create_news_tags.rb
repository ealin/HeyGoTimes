class CreateNewsTags < ActiveRecord::Migration
  def self.up
    create_table :news_tags do |t|
      t.string :news_id
      t.integer :tag_id

    end
  end

  def self.down
    drop_table :news_tags
  end
end
