class User < ActiveRecord::Base
	has_many :pojects
	has_many :votes
	has_many :names, :through => :votes
	has_many :usertags
	has_many :tags, :through => :usertags
end
