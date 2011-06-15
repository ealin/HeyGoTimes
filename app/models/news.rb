class News < ActiveRecord::Base

  belongs_to :user

  has_one :area

  has_many :comments
  has_many :images

  has_many :news_tags
  has_many :tags, :through => :news_tags

  has_many :news_areas
  has_many :areas, :through => :news_areas

  has_many :user_likes
  has_many :likes, :through => :user_likes, :uniq => true, :class_name => "User", :source => :user

  has_many :user_dislikes
  has_many :dislikes, :through => :user_dislikes, :uniq => true, :class_name => "User", :source => :user

  def self.find_by_tags(user_tags)
    #find(
    #  :all,
    #  :order => "created_at DESC",
    #  :joins => :tags,
    #  :conditions => {:tags => {:name => user_tags}},
    #  :group => 'news.id, news.title'
    #)

    #find(
    #  :all,
    #  :order => "created_at DESC",
    #  :include => [:news_tags, :tags],
    #  :conditions => {:tags => {:name => user_tags}},
    #  :group => 'news.id'
    #)

    joins(:tags).where(:tags => {:name => user_tags}).select('DISTINCT (news.id), news.title, news.url, news.content, news.user_id', :order => 'news.created_at DESC')
  end

  def self.get_all
    find(:all, :limit => 10)
  end

end
