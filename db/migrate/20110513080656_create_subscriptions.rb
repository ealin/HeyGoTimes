class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string :user_id
      t.string :paper_id
      t.integer :filter_id

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
