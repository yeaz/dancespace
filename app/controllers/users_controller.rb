class UsersController < ApplicationController
  def new
    @user = User.new
    @user.experiences.build
  end
  
  def create
    @user = User.create(user_params)
    @user.save
    redirect_to 'home#index'
  end

  def edit_profile
    @user = current_user
    @user.experiences.build
    @experience = Experience.new
    @experience.experiencelinks.build
  end

  def update
    @user = current_user
    @user.update(user_params)
    if @user.errors.any?
      @user.errors.each do |attribute, error |
        flash[attribute] = error
      end
    end
    redirect_to '/user_settings'
  end

  def show
    @user = User.find(params[:id])
    get_users_videos(@user.id)
  end

  def get_users_videos(id)
    @users_videos = Video.where(:user_id => id)
    if @users_videos.nil?
      @users_videos = []
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,
                                 :title, :blurb, :city, :state, :style_list,
                                 :experiences_attributes => [:id, :content,
                                                             :experience_links_attributes => [:id, :collab_type, :collab_id]])
  end
  
end
