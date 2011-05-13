class CreateAdGrids < ActiveRecord::Migration
  def self.up
    create_table :ad_grids do |t|
      t.string :ad_id
      t.string :paper_id
      t.integer :user_id
      t.string :url_link
      t.string :image
      t.integer :page
      t.integer :row
      t.integer :column
      t.integer :fee
      t.datetime :issued_tate
      t.integer :public_days
      t.datetime :valid_through

    end
  end

  def self.down
    drop_table :ad_grids
  end
end
