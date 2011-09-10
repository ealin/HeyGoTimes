class CreateRivers < ActiveRecord::Migration
  def self.up
    create_table :rivers do |t|
      t.integer :user_id
      t.string :name
      t.string :location
      t.string :url
      t.integer :position
      t.integer :rank

      t.timestamps
    end
  end

  def self.down
    drop_table :rivers
  end
end
