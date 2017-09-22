class Instructor < ApplicationRecord
	# Associations
  # http://guides.rubyonrails.org/association_basics.html
  belongs_to :user
  has_many :courses
end
