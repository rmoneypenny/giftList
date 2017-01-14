class UsersController < ApplicationController
  
  layout "sessions"
  skip_before_action :require_login

  def new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:notice] = "Account created"
  		redirect_to log_in_path
  	else
  		flash[:alert] = "Account not created"
  		redirect_to new_user_path
  	end

  end

  def destroy
    if User.authenticate(User.find(current_user.id).email, params[:password])
      User.cleanup(current_user.id)
      redirect_to log_out_path
    else
      redirect_to settings_path
    end
  end


private 

def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
end


end

