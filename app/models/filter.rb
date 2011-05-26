class Filter < ActiveRecord::Base
  belongs_to :subscription
  has_many :tags
end
