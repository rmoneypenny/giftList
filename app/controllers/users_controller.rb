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

  def update
    if User.authenticate(User.find(current_user.id).email, params[:current_password]) && params[:new_password] != ""  
      user = User.find(current_user.id)
      user.password = params[:new_password]
      user.save
      flash[:notice] = "Password Updated"
    else
      params[:new_password] == "" ? flash[:error] = "New password cannot be blank" : flash[:error] = "Incorrect Password"
    end
      #puts params[:current_password]
      #puts params[:new_password]
    redirect_to settings_path
  end

private 

def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
end


end

