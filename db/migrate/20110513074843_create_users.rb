class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email

      t.string :locale
      t.datetime :birthday

      # e.g. facebook account of this user, this field would be a email address
      t.string :host_account

      # e.g. facebook account of this user, this field would be a serial-number
      t.integer :host_id

      # host site -   0: hey-go times,  1: facebook
      t.integer :host_site

      t.boolean :admin, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
