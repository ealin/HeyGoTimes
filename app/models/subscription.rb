class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper
  has_many :filters
end
