class Name < ActiveRecord::Base
	belongs_to :project
  acts_as_votable
end
