class CreateAreaFilters < ActiveRecord::Migration
  def self.up
    create_table :area_filters do |t|

      #
      # 因為在 area_filter.rb中已經定義 belongs_to : user, area, 所以自動會產生foreign key ==> user_id, area_id
      #
      t.integer :user_id
      t.integer :area_id

      t.timestamps
    end
  end

  def self.down
    drop_table :area_filters
  end
end
