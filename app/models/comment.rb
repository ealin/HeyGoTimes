class Comment < ActiveRecord::Base
  belongs_to :news
  belongs_to :user
  has_many :responses
end

