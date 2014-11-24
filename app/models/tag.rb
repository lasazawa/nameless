class Tag < ActiveRecord::Base
	has_many :projecttags
	has_many :projects, :through => :projecttag
	has_many :usertags
	has_many :users, :through => :usertags
end
