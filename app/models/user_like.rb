class UserLike < ActiveRecord::Base
  belongs_to :news
  belongs_to :user
end
