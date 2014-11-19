class Project < ActiveRecord::Base
	belongs_to :user
	has_many :names
	has_many :projecttag
	has_many :tags, :through => :projecttag

  validates :name,
    presence: true

  validates :description,
    presence: true

end
