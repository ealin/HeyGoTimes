class CreateDateFilters < ActiveRecord::Migration
  def self.up
    create_table :date_filters do |t|
      t.integer :user_id
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :date_filters
  end
end
