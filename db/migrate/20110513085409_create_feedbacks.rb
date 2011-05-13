class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.string :feedback_id
      t.string :user_id
      t.string :title
      t.integer :type
      t.string :org_feedback_id

      t.timestamps
    end
  end

  def self.down
    drop_table :feedbacks
  end
end
