class Course < ApplicationRecord
	# Associations
  # http://guides.rubyonrails.org/association_basics.html
  belongs_to :instructor
  has_many :course_students
  has_many :students, through: :course_students

  # Validations
  # http://guides.rubyonrails.org/active_record_validations.html
  validates :instructor, presence: true
  validates :name, presence: true, format: { with: /\A(?=.*[\da-zA-Z])\w*\z/, # only alphanumeric and underscore, but not just underscore
                             message: "can only contain alphanumeric and underscore" }

  # Callbacks
  # http://guides.rubyonrails.org/active_record_callbacks.html
  before_save :create_registration_code

  def create_registration_code
    if not self.registration_code
      self.update(registration_code: ('A'..'Z').to_a.concat(('a'..'z').to_a).concat(('1'..'9').to_a).shuffle[0,8].join)
    end
  end

  def open_registration
    self.update(registration_open: true)
  end

  def close_registration
    self.update(registration_open: false)
  end

end
