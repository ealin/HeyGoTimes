class CreateTagFilters < ActiveRecord::Migration
  def self.up
    create_table :tag_filters do |t|

      #
      # 因為在 tag_filter.rb中已經定義 belongs_to : user, tag, 所以自動會產生foreign key ==> user_id, tag_id
      #
      t.integer :user_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tag_filters
  end
end
