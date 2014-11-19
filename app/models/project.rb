class Project < ActiveRecord::Base
	belongs_to :user
	has_many :names 
	has_many :projecttag
	has_many :tags, :through => :projecttag
end
