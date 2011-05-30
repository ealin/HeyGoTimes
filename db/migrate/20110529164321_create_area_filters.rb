class CreateAreaFilters < ActiveRecord::Migration
  def self.up
    create_table :area_filters do |t|
      t.integer :user_id
      t.integer :area_id

      t.timestamps
    end
  end

  def self.down
    drop_table :area_filters
  end
end
