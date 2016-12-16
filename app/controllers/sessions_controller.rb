class SessionsController < ApplicationController

	layout "sessions"
	skip_before_action :require_login

	def create
		@user = User.authenticate(params[:email], params[:password])

		if @user
			flash[:notice] = "Logged in"
			session[:user_id] = @user.id
			puts "success"
			redirect_to mylist_path
		else
			flash[:alert] = "Unable to log in"
			puts "fail"
			redirect_to log_in_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logged our"
		redirect_to log_in_path
	end
end
