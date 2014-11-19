class User < ActiveRecord::Base
	has_secure_password

	has_many :projects
	has_many :votes
	has_many :names, :through => :votes
	has_many :usertags
	has_many :tags, :through => :usertags

	validates :username,
		presence: true,
		uniquness: true
	validates :password,
		presence: true,
		length: {minimum: 5}
end
