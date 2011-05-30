class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|

      # which user has commented with which news.
      #
      t.integer :user_id
      t.string :news_id


      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
