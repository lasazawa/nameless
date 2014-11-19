class Tag < ActiveRecord::Base
	has_many :projecttag
	has_many :projects, :through => :projecttag
	has_many :usertag
	has_many :users, :through => :usertags
end
