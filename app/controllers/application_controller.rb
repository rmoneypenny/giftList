class ApplicationController < ActionController::Base
protect_from_forgery with: :exception

helper_method :current_user

before_action :require_login

  	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def require_login
		if !self.current_user
			redirect_to log_in_path
		end
	end

end
