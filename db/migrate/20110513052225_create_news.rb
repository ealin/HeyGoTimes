class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :title
      t.string :url
      t.string :area_string
      t.text :content

      t.integer :user_id
      t.integer :area_id
      t.integer :rank
      t.text :hard_copy

      t.boolean :special_flag, :default => false
      t.boolean :mobile_flag, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :news
  end
end
