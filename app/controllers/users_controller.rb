class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  include UsersHelper
  include StudioHelper
  
  def index
    @users = User.search params[:search]
  end

  def new
    @user = User.new
    @user.experiences.build
  end
  
  def create
    u_params = fix_contact_urls(user_params)

    @user = User.create(u_params)
    @user.save
    redirect_to 'home#index'
  end

  def edit_profile
    @user = current_user
  end

  def add_experience
    @user = current_user
    @user.experiences.build
    @experience = Experience.new
    @experience.experiencelinks.build
  end

  def update
    @user = current_user
    u_params = fix_contact_urls(user_params)
    upload_photo(u_params, @user.id.to_s)
    @user.update(u_params)
    if @user.errors.any?
      flash[:user_errors] = {}
      @user.errors.each do |attribute, error |
        flash[:user_errors][attribute] = error
      end
    end
    redirect_to user_path(@user)
  end

  def show
    @user = User.find(params[:id])
    # facebook
    @fb_posts = get_facebook_posts(@user)
  end

  def get_random_user
    @user = User.offset(rand(User.count)).first
    respond_to do |format|
      format.json { render json: @user} # take the fields we need only [email: @user.email, id: @user.id]
    end    
  end

  def get_all_dancers
    @users = User.all
    respond_to do |format|
      format.json{ render json: @users}
    end
  end

  def get_search_dancers
    @results = User.search params[:query]
    respond_to do |format|
      format.json{render json: @results}
    end
  end

  def upload_photo(u_params, id)
    if !u_params.has_key?(:photo_path) or u_params[:photo_path].nil?
      return
    end
    uploaded_io = u_params[:photo_path]
    extension = File.extname(uploaded_io.original_filename)
    filename = Rails.root.join('public', 'images', 'uploads', 'users', id + extension)
    File.open(filename, 'wb')  do |file|
      file.write(uploaded_io.read)
    end
    u_params[:photo_path] = '/uploads/users/' + id + extension
  end
  
  private

  def user_params
    params.require(:user).permit(:photo_path, :email, :password, :password_confirmation,
                                 :title, :blurb, :city, :state, :style_list, :fb_url, :yt_url,
                                 :ig_url, :website_url, :twtr_url, :phone_area_code, :phone_1, :phone_2, 
                                 :experiences_attributes => [:id, :content,
                                                             :experience_links_attributes => [:id, :collab_type, :collab_id]])
  end
  
end
