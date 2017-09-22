class Student < ApplicationRecord
  # Associations
  # http://guides.rubyonrails.org/association_basics.html
	belongs_to :user
	has_many :course_students
	has_many :courses, through: :course_students
end
