class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.string :parent_tag

      # Ealin: this filed is only for controller, it's not meaningful when the record saved in DB.
      #    (it would waste a little DB space, it's ok because there's not so many tags in our application.')
      #
      t.integer :checked

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
