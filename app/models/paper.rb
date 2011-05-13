class Paper < ActiveRecord::Base
  has_many :news
  has_one :area
  has_one :user
  has_many :subscriptions
  has_many :ad_grids
end
