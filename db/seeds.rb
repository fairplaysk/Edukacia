# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.find(:first, :conditions => {:username => 'admin', :email => 'admin@kwizzer.sk'}) || User.create(:username => 'admin', :password => 'changeme', :email => 'admin@kwizzer.sk')