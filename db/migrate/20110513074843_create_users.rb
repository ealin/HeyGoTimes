class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.string :locale
      t.datetime :birthday
      t.string :host_account
      t.integer :host_id
      t.integer :host_site


      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
