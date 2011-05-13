class User < ActiveRecord::Base
  belongs_to :news
  belongs_to :paper
  has_many :subscriptions
  has_many :comments
  has_many :feedbacks
  has_many :ad_grids
end
