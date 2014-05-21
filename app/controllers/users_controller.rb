class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @users = User.all
  end

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
      flash[:user_errors] = {}
      @user.errors.each do |attribute, error |
        flash[:user_errors][attribute] = error
      end
    end
    redirect_to '/user_settings'
  end

  def show
    @user = User.find(params[:id])
  end

  def get_random_user
    @user = User.offset(rand(User.count)).first
    redirect_to user_path(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,
                                 :title, :blurb, :city, :state, :style_list, :fb_url, :yt_url,
                                 :ig_url, :website_url, :twtr_url, :phone_area_code, :phone_1, :phone_2, 
                                 :experiences_attributes => [:id, :content,
                                                             :experience_links_attributes => [:id, :collab_type, :collab_id]])
  end
  
end
