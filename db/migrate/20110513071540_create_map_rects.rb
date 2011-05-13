class CreateMapRects < ActiveRecord::Migration
  def self.up
    create_table :map_rects do |t|
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :map_rects
  end
end
