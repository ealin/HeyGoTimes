class AddRiverDetail < ActiveRecord::Migration
  def self.up
    add_column :rivers, :description, :text
    add_column :rivers, :img, :string
  end

  def self.down
    remove_column :description
    remove_column :img
  end
end
