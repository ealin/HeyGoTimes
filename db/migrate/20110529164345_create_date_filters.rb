class CreateDateFilters < ActiveRecord::Migration
  def self.up
    create_table :date_filters do |t|

      #
      # 因為在 date_filter.rb中已經定義 belongs_to : user, 所以自動會產生foreign key ==> user_id
      #
      t.integer :user_id

      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :date_filters
  end
end
