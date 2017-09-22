class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  ## Authenticate methods for use in other controllers
  def user_not_authorized
    flash[:alert] = "Access denied."
    redirect_to (request.referrer || root_path)
  end

  def authenticate_admin
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.admin?
        return
      end
    end
    user_not_authorized
  end

  def authenticate_developer
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.developer?
        return
      end
    end
    user_not_authorized
  end

  def authenticate_instructor
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.instructor?
        return
      end
    end
    user_not_authorized
  end

  def authenticate_teacher_aid
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.instructor?
        return
      end
    end
    user_not_authorized
  end

  def authenticate_student
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.student?
        return
      end
    end
    user_not_authorized
  end

  def authenticate_admin_or_instructor
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.admin? || @user.instructor?
        return
      end
    end
    user_not_authorized
  end

  def authenticate_admin_or_developer
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.admin? || @user.developer?
        return
      end
    end
    user_not_authorized
  end

  def authenticate_admin_instructor_or_teacher_aid
    if user_signed_in?
      @user = User.find(current_user.id)
      if @user.admin? || @user.instructor? || @user.teacher_aid?
        return
      end
    end
    user_not_authorized
  end

end
