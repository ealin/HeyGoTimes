class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string :area_id
      t.string :name
      t.string :parent_area_id
      t.integer :level
      t.string :latitude
      t.string :longtitude
      t.string :map_id

      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
