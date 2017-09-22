class UserController < ApplicationController
	before_action :authenticate_user! # For devise authentication methods
end
