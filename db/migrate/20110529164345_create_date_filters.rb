class CreateDateFilters < ActiveRecord::Migration
  def self.up
    create_table :date_filters do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :date_filters
  end
end
