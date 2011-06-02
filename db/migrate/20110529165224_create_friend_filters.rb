class CreateFriendFilters < ActiveRecord::Migration
  def self.up
    create_table :friend_filters do |t|
      #
      # 因為在 friend_filter.rb中已經定義 belongs_to : user, 所以自動會產生foreign key ==> user_id
      #
      t.integer :user_id

      # 0: me,  1: all-my-friends,  2: user-id,  3: group-id
      #
      t.integer :type

      t.integer :following_id

    end
  end

  def self.down
    drop_table :friend_filters
  end
end
