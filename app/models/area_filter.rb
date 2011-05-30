class AreaFilter < ActiveRecord::Base
  belongs_to :user
  has_one :area

end
