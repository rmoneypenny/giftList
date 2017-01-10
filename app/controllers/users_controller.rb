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
  		render "new"
  	end

  end

  def destroy
    if User.authenticate(User.find(current_user.id).email, params[:password])
      #make a method in User.rb called cleanup that will mark all items w/current_user.id as deleted. Compare item_id w/Purchases and delete accordingly
    end
    redirect_to settings_path
  end


private 

def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
end


end

