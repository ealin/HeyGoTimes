class Area < ActiveRecord::Base

  has_many :area_filters
  has_many :users, :through => :area_filters


  # 會自動產生foreign key ===> news_id
  belongs_to :news

end
