class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|

      #
      # 因為在 comment.rb中已經定義 belongs_to : user & news, 所以自動會產生foreign key ==> user_id & news_id
      #
      # which user has commented with which news.
      #
      t.integer :user_id
      t.integer :news_id

      t.string :content


      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
