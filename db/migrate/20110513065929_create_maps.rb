class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.string :map_id
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :maps
  end
end
