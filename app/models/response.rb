class Response < ActiveRecord::Base
  belongs_to :comment
  belongs_to :feedback
end
