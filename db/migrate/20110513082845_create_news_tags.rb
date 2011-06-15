class CreateNewsTags < ActiveRecord::Migration
  def self.up
    create_table :news_tags do |t|

      #
      # 因為在 news_tag.rb中已經定義 belongs_to : news, tag, 所以自動會產生foreign key ==> news_id, tag_id
      #
      t.integer :news_id
      t.integer :tag_id

    end
  end

  def self.down
    drop_table :news_tags
  end
end
