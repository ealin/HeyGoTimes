class News < ActiveRecord::Base

  belongs_to :user

  has_many :comments, :dependent => :destroy
  has_many :images, :dependent => :destroy

  has_many :news_tags, :dependent => :destroy
  has_many :tags, :through => :news_tags

  has_many :news_areas, :dependent => :destroy
  has_many :areas, :through => :news_areas

  has_many :user_likes, :dependent => :destroy
  has_many :likes, :through => :user_likes, :uniq => true, :class_name => "User", :source => :user

  has_many :user_unlikes, :dependent => :destroy
  has_many :unlikes, :through => :user_unlikes, :uniq => true, :class_name => "User", :source => :user

  has_many :user_watches, :dependent => :destroy
  has_many :watches, :through => :user_watches, :uniq => true, :class_name => "User", :source => :user

  has_many :user_news_ranks, :dependent => :destroy

  def self.find_by_tags(type, friend_type, user_id, user_areas, user_tags)

    case friend_type
      when :none
        if (user_areas[0] == 'All_area')
          if (type == 'latest')
            joins(:tags).where(:news=>{:special_flag => false}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
          else
            joins(:tags).where(:news=>{:special_flag => false}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
          end
        elsif (user_tags[0] == 'All')
          if (type == 'latest')
            joins(:areas).where(:news=>{:special_flag => false}, :areas => {:name => user_areas}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
          else
            joins(:areas).where(:news=>{:special_flag => false}, :areas => {:name => user_areas}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
          end
        else
          if (type == 'latest')
            joins(:areas, :tags).where(:news=>{:special_flag => false}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
          else
            joins(:areas, :tags).where(:news=>{:special_flag => false}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).select('DISTINCT (news.id), news.*').order('news.rank DESC, news.created_at DESC')
          end
        end

      when :mine, :friend
        my_news = (friend_type == :mine)? true: false

        if (user_areas[0] == 'All_area')
          if (type == 'latest')
            joins(:user_news_ranks, :tags).select('DISTINCT (news.id), news.*').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :user_news_ranks=>{:my_news => my_news}, :tags => {:name => user_tags}).order('news.created_at DESC')
          else
            joins(:user_news_ranks, :tags).select('DISTINCT (news.id), news.*, user_news_ranks.rank').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :user_news_ranks=>{:my_news => my_news}, :tags => {:name => user_tags}).order('user_news_ranks.rank DESC, news.created_at DESC')
          end
        elsif (user_tags[0] == 'All')
          if (type == 'latest')
            joins(:user_news_ranks, :areas).select('DISTINCT (news.id), news.*').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :user_news_ranks=>{:my_news => my_news}, :areas => {:name => user_areas}).order('news.created_at DESC')
          else
            joins(:user_news_ranks, :areas).select('DISTINCT (news.id), news.*, user_news_ranks.rank').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :user_news_ranks=>{:my_news => my_news}, :areas => {:name => user_areas}).order('user_news_ranks.rank DESC, news.created_at DESC')
          end
        else
          if (type == 'latest')
            joins(:user_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :user_news_ranks=>{:my_news => my_news}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('news.created_at DESC')
          else
            joins(:user_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*, user_news_ranks.rank').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :user_news_ranks=>{:my_news => my_news}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('user_news_ranks.rank DESC, news.created_at DESC')
          end
        end

      when :both

        if (user_areas[0] == 'All_area')
          if (type == 'latest')
            joins(:user_news_ranks, :tags).select('DISTINCT (news.id), news.*').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :tags => {:name => user_tags}).order('news.created_at DESC')
          else
            joins(:user_news_ranks, :tags).select('DISTINCT (news.id), news.*, user_news_ranks.rank').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :tags => {:name => user_tags}).order('user_news_ranks.rank DESC, news.created_at DESC')
          end
        elsif (user_tags[0] == 'All')
          if (type == 'latest')
            joins(:user_news_ranks, :areas).select('DISTINCT (news.id), news.*').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}).order('news.created_at DESC')
          else
            joins(:user_news_ranks, :areas).select('DISTINCT (news.id), news.*, user_news_ranks.rank').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}).order('user_news_ranks.rank DESC, news.created_at DESC')
          end
        else
          if (type == 'latest')
            joins(:user_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('news.created_at DESC')
          else
            joins(:user_news_ranks, :areas, :tags).select('DISTINCT (news.id), news.*, user_news_ranks.rank').where(:news=>{:special_flag => false}, :user_news_ranks=>{:user_id => user_id}, :areas => {:name => user_areas}, :tags => {:name => user_tags}).order('user_news_ranks.rank DESC, news.created_at DESC')
          end
        end

    end

  end

# @param type [String=>latest/rank]
# @param friend_type [Symbol=>none/both/mine/friend]
# @param user_id [Integer], valid if friend_type != none
  def self.get_all(type, friend_type, user_id)

    if (friend_type != :none)
      user = User.find(user_id)
    end

    case friend_type
      when :none
        if (type == 'latest')
          find(:all, :conditions => {:news=>{:special_flag => false}}, :order => 'created_at DESC')
        else
          find(:all, :conditions => {:news=>{:special_flag => false}}, :order => 'rank DESC')
        end

      when :mine
        if (type == 'latest')
          user.my_news.where(:news=>{:special_flag => false}).order('news.created_at DESC')
        else
          user.my_news_by_rank.select('user_news_ranks.rank').where(:news=>{:special_flag => false}).order('user_news_ranks.rank DESC, news.created_at DESC')
        end

      when :friend
        if (type == 'latest')
          user.friend_news.where(:news=>{:special_flag => false}).order('news.created_at DESC')
        else
          user.friend_news_by_rank.select('user_news_ranks.rank').where(:news=>{:special_flag => false}).order('user_news_ranks.rank DESC, news.created_at DESC')
        end

      when :both
        if (type == 'latest')
          user.both_news.where(:news=>{:special_flag => false}).order('news.created_at DESC')
        else
          user.both_news.select('user_news_ranks.rank').where(:news=>{:special_flag => false}).order('user_news_ranks.rank DESC, news.created_at DESC')
        end

       #joins(:my_news_ranks, :user_news_ranks).where(:my_news_ranks=>{:user_id=>user_id}, :user_news_ranks=>{:user_id=>user_id}).order('news.created_at DESC', :limit => 10)
    end

  end

  def self.get_all_special(areas, tags, friend_type, user_id)

    if (friend_type == :mine)
      user = User.find(user_id)
      user.my_news.joins(:areas, :tags).where(:news=>{:special_flag => true}, :areas => {:name => areas}, :tags => {:name => tags}).select('news.*').order('news.created_at DESC')
    else
      joins(:areas, :tags).where(:news=>{:special_flag => true}, :areas => {:name => areas}, :tags => {:name => tags}).select('DISTINCT (news.id), news.*').order('news.created_at DESC')
    end
  end

end
