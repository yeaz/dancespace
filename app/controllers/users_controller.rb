class UsersController < ApplicationController
  
  def create
    @user = User.create(user_params)
    @user.save
    redirect_to 'home#index'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :role)
  end
  
end
