class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.string :feedback_id
      t.string :comment_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
