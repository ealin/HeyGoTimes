class CreateFilters < ActiveRecord::Migration
  def self.up
    create_table :filters do |t|
      t.integer :subscription_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :filters
  end
end
