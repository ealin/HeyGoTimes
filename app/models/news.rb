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

  has_many :user_watches
  has_many :watches, :through => :user_watches, :uniq => true, :class_name => "User", :source => :user

  def self.find_by_tags(type, user_areas, user_tags)
    #find(
    #  :all,
    #  :order => "created_at DESC",
    #  :joins => :tags,
    #  :conditions => {:tags => {:name => user_tags}},
    #  :group => 'news.id'
    #)

    #find(
    #  :all,
    #  :order => "created_at DESC",
    #  :include => [:news_tags, :tags],
    #  :conditions => {:tags => {:name => user_tags}},
    #  :group => 'news.id'
    #)
    if (user_areas[0] == 'All')
      if (type == 'latest')
        joins(:tags).where(:tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
      else
        joins(:tags).where(:tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
      end
    else
      if (type == 'latest')
        joins(:areas, :tags).where(:areas => {:name => user_areas}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
      else
        joins(:areas, :tags).where(:areas => {:name => user_areas}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
      end
    end

  end

  def self.get_all(type)
    if (type == 'latest')
      find(:all, :order => 'created_at DESC', :limit => 10)
    else
      find(:all, :order => 'rank DESC', :limit => 10)
    end

  end

end
