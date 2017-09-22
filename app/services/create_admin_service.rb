class CreateAdminService
  def call
  	user = nil
  	if not user = User.find_by_email(Rails.application.secrets.admin_email)
  		user = User.new(email: Rails.application.secrets.admin_email, username: Rails.application.secrets.admin_username, \
        first_name: Rails.application.secrets.admin_first_name, last_name: Rails.application.secrets.admin_last_name, \
        organization: Rails.application.secrets.admin_organization, approved: true)
  	end
  	user.password = Rails.application.secrets.admin_password
  	user.password_confirmation = Rails.application.secrets.admin_password
	if not user.save
		puts "FAILED TO CREATE USER: #{user.errors.messages}"
		return false
        end
  	user.set_role_admin
    user
  end
end
