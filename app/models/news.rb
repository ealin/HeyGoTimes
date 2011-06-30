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

  has_many :user_unlikes
  has_many :unlikes, :through => :user_unlikes, :uniq => true, :class_name => "User", :source => :user

  has_many :user_watches
  has_many :watches, :through => :user_watches, :uniq => true, :class_name => "User", :source => :user

  has_many :my_news_ranks
  has_many :user_news_ranks

  def self.find_by_tags(type, friend_type, user_id, user_areas, user_tags)
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

    case friend_type
      when :none
        if (user_areas[0] == 'All')
          if (type == 'latest')
            joins(:tags).where(:tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
          else
            joins(:tags).where(:tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
          end
        elsif (user_tags[0] == 'All')
          if (type == 'latest')
            joins(:areas).where(:areas => {:name => user_areas}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
          else
            joins(:areas).where(:areas => {:name => user_areas}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
          end
        else
          if (type == 'latest')
            joins(:areas, :tags).where(:areas => {:name => user_areas}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
          else
            joins(:areas, :tags).where(:areas => {:name => user_areas}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
          end
        end
      when :mine
        @user = User.find(user_id)
        if (user_areas[0] == 'All')
          if (type == 'latest')
            joins(:my_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:my_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('news.created_at DESC')
          else
            joins(:my_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:my_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('my_news_ranks.rank DESC, news.created_at DESC')
          end
        elsif (user_tags[0] == 'All')
          if (type == 'latest')
            joins(:my_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:my_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('news.created_at DESC')
          else
            joins(:my_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:my_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('my_news_ranks.rank DESC, news.created_at DESC')
          end
        else
          if (type == 'latest')
            joins(:my_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:my_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('news.created_at DESC')
          else
            joins(:my_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:my_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('my_news_ranks.rank DESC, news.created_at DESC')
          end
        end
      when :friend
      when :both
    end

  end

# @param type [String=>latest/rank]
# @param friend_type [Symbol=>none/both/mine/friend]
# @param user_id [Integer], valid if friend_type != none
  def self.get_all(type, friend_type, user_id)

    case friend_type
      when :none
        if (type == 'latest')
          find(:all, :order => 'created_at DESC', :limit => 10)
        else
          find(:all, :order => 'rank DESC', :limit => 10)
        end

      when :mine
        @user = User.find(user_id)
        if (type == 'latest')
          @user.my_news.order('news.created_at DESC', :limit => 10)
        else
          @user.my_news_by_rank.order('news.created_at DESC', :limit => 10)
        end

      when :friend
        @user = User.find(user_id)
        if (type == 'latest')
          @user.friend_news.order('news.created_at DESC', :limit => 10)
        else
          @user.friend_news_by_rank.order('news.created_at DESC', :limit => 10)
        end
      when :both
        @user = User.find(user_id)
        @user.my_news.joins(@user.friend_news)
       #joins(:my_news_ranks, :user_news_ranks).where(:my_news_ranks=>{:user_id=>user_id}, :user_news_ranks=>{:user_id=>user_id}).order('news.created_at DESC', :limit => 10)
    end

  end

end
