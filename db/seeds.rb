# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default User~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
User.create(:first_name => 'Reporter', :last_name => 'TW',:email => 'reporter.tw@heygotimes.com',
    :locale => 'zh_TW', :birthday => '2011-05-01 09:00:00',  :host_id => 0,  :host_site => 0)

User.create(:first_name => 'HGTimes', :last_name => 'Taiwan',:email => 'heygoinc@gmail.com',
    :locale => 'zh_TW', :birthday => '2011-07-01 09:00:00',  :host_id => 0,  :host_site => 0)
#
#  :host_site = 0  means this account is belongs to HeyGoTimes


#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default Area~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#

Area.create(:name => 'All_area', :parent_area =>nil)
Area.create(:name => 'Taiwan', :parent_area =>nil)
Area.create(:name => 'TW_CN', :parent_area => 'Taiwan')
Area.create(:name => 'North_TW', :parent_area => 'Taiwan')
Area.create(:name => 'Middle_TW', :parent_area => 'Taiwan')
Area.create(:name => 'South_TW', :parent_area => 'Taiwan')
Area.create(:name => 'East_TW', :parent_area => 'Taiwan')

Area.create(:name => 'China', :parent_area => nil)
Area.create(:name => 'TW_HK', :parent_area => "China")

Area.create(:name => 'USA', :parent_area => nil)
Area.create(:name => 'Japan', :parent_area => nil)
Area.create(:name => 'Europe', :parent_area => nil)
Area.create(:name => 'Asia', :parent_area => nil)
Area.create(:name => 'Others', :parent_area => nil)


#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default Tag~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
Tag.create(:name => 'All', :parent_tag => nil)

Tag.create(:name => 'HGTimesNotice', :parent_tag => nil)
Tag.create(:name => 'FeedbackTag', :parent_tag => nil)

#Tag.create(:name => 'Mobile', :parent_tag => nil)
Tag.create(:name => 'Motion', :parent_tag => nil)
Tag.create(:name => 'World', :parent_tag => nil)
Tag.create(:name => 'Society', :parent_tag => nil)
Tag.create(:name => 'Local', :parent_tag => nil)

Tag.create(:name => 'Politics', :parent_tag => nil)
Tag.create(:name => 'Life', :parent_tag => nil)

Tag.create(:name => 'Business', :parent_tag => nil)
#Tag.create(:name => 'Stock', :parent_tag => 'Business')

Tag.create(:name => 'Sci_Tech' , :parent_tag => nil)
Tag.create(:name => 'Sport', :parent_tag => nil)
#Tag.create(:name => 'NBA', :parent_tag => 'Sport')
#Tag.create(:name => 'Baseball', :parent_tag => 'Sport')

Tag.create(:name => 'Entertainment', :parent_tag => nil)
Tag.create(:name => 'Health', :parent_tag => nil)
Tag.create(:name => 'Internet', :parent_tag => nil)
Tag.create(:name => 'Travel', :parent_tag => nil)
#Tag.create(:name => 'Car', :parent_tag => nil)
Tag.create(:name => 'Education', :parent_tag => nil)
Tag.create(:name => 'Art', :parent_tag => nil)
Tag.create(:name => 'Special', :parent_tag => nil)


# NOTE: FAQ should be the last one!!!
#
Tag.create(:name => 'FAQ', :parent_tag => nil)


#~~~~~~~~~~~~~~~~~~~~~~~~~Create Default News (for FAQ)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#  Title = Q,  Content = A

image = Image.create(:url => "http://heygotimes-bench.heroku.com/images/HeyGoTimes_logo.png?1309676569")
tag = Tag.find_by_name("FAQ")
area_tw = Area.find_by_name("Taiwan")
area_usa = Area.find_by_name("USA")
user = User.find(2)

# SOP to create a new FAQ entry
#
# ---------- Q1 (TW) --------------
#
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = "Q1"
news.content = "A1"
news.url = "http://www.yahoo.com"
news.area_string = ""

news.save
image.news = news
image.save

# ---------- Q2 (TW) --------------
#
image = Image.create(:url => "http://heygotimes-bench.heroku.com/images/HeyGoTimes_logo.png?1309676569")
news = News.new(:special_flag => true)
news.tags = []
news.tags << tag
news.areas = []
news.areas << area_tw
news.user = user
news.title = "Q2"
news.content = "A1"
news.url = "http://www.yahoo.com"
news.area_string = ""

news.save
image.news = news
image.save


