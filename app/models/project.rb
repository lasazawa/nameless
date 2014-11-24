class Project < ActiveRecord::Base
	belongs_to :user
  has_many :comments
	has_many :names
	has_many :projecttags
	has_many :tags, :through => :projecttags

  validates :name,
    presence: true

  validates :description,
    presence: true

end
