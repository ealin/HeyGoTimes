class CreateRiverEvents < ActiveRecord::Migration
  def self.up
    create_table :river_events do |t|
      t.integer :news_id
      t.integer :river_id
      t.datetime :event_dt
    end
  end

  def self.down
    drop_table :river_events
  end
end
