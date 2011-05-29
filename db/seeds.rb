# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


User.create(:first_name => 'Reporter', :last_name => 'TW',:email => 'reporter.tw@heygotimes.com',
    :locale => 'zh_TW', :birthday => '2011-05-01 09:00:00',  :host_id => 0,  :host_site => 0)
#
#  :host_site = 0  means this account is belongs to HeyGoTimes


