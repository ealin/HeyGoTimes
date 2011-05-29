class CreateAreaFilters < ActiveRecord::Migration
  def self.up
    create_table :area_filters do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :area_filters
  end
end
