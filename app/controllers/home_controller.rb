class HomeController < ApplicationController
  def index
    if user_signed_in?
      user = User.find(current_user.id)
      if user.admin?
        redirect_to '/admin'
      elsif user.developer?
        redirect_to '/developer'          
      elsif user.instructor?
        redirect_to '/instructor'
      elsif user.teacher_aid?
        redirect_to '/teacher_aid'
      elsif user.student?
        redirect_to '/student'
      end
    else
      redirect_to new_user_session_path
    end
  end
end