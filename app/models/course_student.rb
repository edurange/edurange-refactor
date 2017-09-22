class CourseStudent < ApplicationRecord
	# Associations
  # http://guides.rubyonrails.org/association_basics.html
  belongs_to :course
  belongs_to :student
end
