class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.string :paper_id
      t.string :image
      t.string :description
      t.integer :user_id
      t.integer :publish_type
      t.string :area_id

      t.timestamps
    end
  end

  def self.down
    drop_table :papers
  end
end
