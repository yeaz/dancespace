class UsersController < ApplicationController
  
  def create
    @user = User.create(user_params)
    @user.save
    redirect_to 'home#index'
  end

  def edit_profile
    @user = current_user
  end

  def update
    @user = current_user
    @user.update!(user_params)
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :title, :blurb, :city, :state, :style_list)
  end
  
end
