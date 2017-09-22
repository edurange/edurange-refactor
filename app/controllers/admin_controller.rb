class AdminController < ApplicationController
	 before_action :authenticate_admin

  def index
  	@unapproved_users = User.where(approved: false)
  end

  # Approve instructor and developer accounts
  def approve_user
    if @user = User.find(params[:id])
      @user.approve_user
    else
    	@user.errors.add(:email, "User doesn't exist!")
    end

    respond_to do |format|
      format.js { render 'admin/js/approve_user.js.erb', :layout => false }
    end
  end

end
