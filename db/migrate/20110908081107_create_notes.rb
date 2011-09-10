class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :river_id
      t.text :content
      t.datetime :note_dt
      t.string :comment_url
    end
  end

  def self.down
    drop_table :notes
  end
end
