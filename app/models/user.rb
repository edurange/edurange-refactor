class User < ApplicationRecord
  attr_accessor :registration_role, :registration_code
	# Associations
  # http://guides.rubyonrails.org/association_basics.html
	has_one :student, dependent: :destroy
	has_one :instructor, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  enum role: [:student, :teacher_aid, :instructor, :developer, :admin]

  # Validations
  # http://guides.rubyonrails.org/active_record_validations.html
  validate :password_complexity
  validates :first_name, :last_name, presence: true
	validates :username, presence: true, uniqueness: true, format: { with: /\A(?=.*[\da-zA-Z])\w*\z/, # only alphanumeric and underscore, but not just underscore
                             message: "can only contain alphanumeric and underscore" }
	# validates :organization, presence: true, if: Proc.new { |o| o.registration_role != "0" }
	validates :registration_code, presence: true, if: Proc.new { |o| o.registration_role == "0" }

  # Callbacks
  # http://guides.rubyonrails.org/active_record_callbacks.html
  after_create :setup

  def setup
    create_student
    if self.instructor?
      create_instructor
    end
    if self.developer?
      create_instructor
      # Finish once developer stuff is setup
    end
    if self.admin?
      create_instructor
    end
  end

  def create_student
    if not self.student
      stu = Student.new(user_id: self.id)
      stu.save
    end
  end

  def create_instructor
    if not self.instructor
      inst = Instructor.new(user_id: self.id)
      inst.save
    end
  end
	
  def registration_role=(role)
    if role == "2"
      set_role_instructor
    elsif role == "3"
      set_role_developer
    end
  end

  # def registration_role

  # end

  def password_complexity
    if password.present?
       if !password.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])/) 
         errors.add :password, "requirements not met."
       end
    end
  end

  ## For Devise
  def active_for_authentication? 
    super && approved? 
  end 
  ## For Devise
  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def name
    self.first_name + " " + self.last_name
  end

  def approve_user
    self.update(approved: true)
  end

  ## Functions for updating role attribute
  def set_role_admin
    self.update(role: :admin)
  end

  def set_role_developer
    self.update(role: :developer)
  end

  def set_role_instructor
    self.update(role: :instructor)
  end

  def set_role_teacher_aid
    self.update(role: :teacher_aid)
  end

  def set_role_student
    self.update(role: :student)
  end

  def is_student
    self.student?
  end
end
