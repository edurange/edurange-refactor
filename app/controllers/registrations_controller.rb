class RegistrationsController < Devise::RegistrationsController
	respond_to :html, :js

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up) do |user_params|
	    user_params.permit(:registration_code, :registration_role, :username, :email, :first_name,:last_name, 
        :organization, :password, :password_confirmation)
	  end
	end

  public

  def create
  	# If registering as student, check if registration_code is valid
  	if params[:user][:registration_role] != "2" and params[:user][:registration_role] != "3"
			query = "registration_code = ?"
			course = Course.where(query, params[:user][:registration_code]).first
			if params[:user][:registration_code] == '' or course.nil?
				build_resource(sign_up_params)
				resource.errors.add :registration_code, " is not valid"
				respond_with resource
        return
			end
  	end
    # Everything below here, with the exception of marked 'if' block, is standard Devise::RegistrationsController create method
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?

      # If registering as student, add to appropriate course, set to teachers organization, and approve user
      if params[:user][:registration_role] != "2" and params[:user][:registration_role] != "3"
        query = "user_id = ?"
        student = Student.where(query, resource.id).first
        course_student = CourseStudent.new(course_id: course.id, student_id: student.id)
        course_student.save
        resource.approve_user
        resource.update(organization: course.instructor.user.organization)
      end

      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

end