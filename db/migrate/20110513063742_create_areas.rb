class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|

      t.string :name
      t.string :primary_tag


      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end
