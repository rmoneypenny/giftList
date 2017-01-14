class SessionsController < ApplicationController

	layout "sessions"
	skip_before_action :require_login

	def create
		@user = User.authenticate(params[:email], params[:password])

		if @user
			session[:user_id] = @user.id
			redirect_to mylist_path
		else
			flash[:alert] = "Unable to log in"
			redirect_to log_in_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:logout] = "Logged out"
		redirect_to log_in_path
	end
end
