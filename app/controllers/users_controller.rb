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

  def show
    @user = current_user
    get_users_videos(@user.id)
  end

  def get_users_videos(id)
    @users_videos = Video.where(:user_id => id)
    if @users_videos.nil?
      @users_videos = []
    end
    puts 'USERS_VIDEOS = ', @users_videos
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :title, :blurb, :city, :state, :style_list)
  end
  
end
