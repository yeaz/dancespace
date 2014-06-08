class StudiosController < ApplicationController

  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index]
  before_action :get_studio, only: [:edit, :update, :show, :destroy, :get_all_yt_videos]

  include UsersHelper
  include StudioHelper
  
  def index
    @studios = Studio.limit(20)
  end
  
  def new
    @studio = Studio.new
  end
  
  def create
    s_params = fix_contact_urls(studio_params)
    photo_path = s_params[:photo_path]
    s_params.delete(:photo_path)
    @studio = Studio.new(s_params)
    if @studio.save
      upload_photo(s_params, @studio.id.to_s, photo_path)
      @studio.update(s_params)
      create_membership
      redirect_to studio_path(@studio)
    else
      render 'new'
    end
  end
    
  def update
    s_params = fix_contact_urls(studio_params)
    upload_photo(s_params, @studio.id.to_s, s_params[:photo_path])
    if @studio.update_attributes(s_params)
      redirect_to studio_path(@studio)
    else
      render 'edit'
    end
  end
  
  def destroy
  end

  def get_all_yt_videos
    if @studio.yt_username.blank?
      redirect_to studio_path(@studio)
    else
      pageToken = params[:page]
      response = get_youtube_api_response(@studio, 50, pageToken, "yt_username")
      @prevPageToken = response[:prevPageToken]
      @nextPageToken = response[:nextPageToken]
      @videos = response[:items] 
    end
  end

  def nearby
    @studios = Studio.all
  end

  def show
    @events = Event.where("studio_id = ?",  params[:id])
    
    # Youtube
    pageToken = params[:page]
    response = get_youtube_api_response(@studio, 5, pageToken, "yt_username")
    if response.nil?
      @videos = nil
    else
      @videos = response[:items]
    end
    
    # Facebook
    @fb_posts = get_facebook_posts(@studio)
    
    # Twitter
    @tweets = get_tweets(@studio, "twtr_username")
    
    # Instagram
    @ig_photos = get_instagram_photos(@studio)
  end

  def set_location
    @studio = Studio.find(params[:studio_id])
  end

  def set_coordinates
    @studio = Studio.find(params[:studio_id])
    @studio.update(is_location_set: params[:set])
    if params.has_key?(:lat)
      @studio.update({lat: params[:lat].to_f, lng: params[:lng].to_f})
    end
    render :json => {"success" => "true"}
  end

  def get_address
    @studio = Studio.find(params[:studio_id])
    if @studio.is_location_set == -1
      render :json => {"address" => @studio.get_address}
    elsif @studio.is_location_set == 1
      render :json => {"lat" => @studio.lat, "lng" => @studio.lng}
    elsif @studio.is_location_set == 0
      render :json => {"error" => "true"}
    end
  end

  def get_coordinates
    @studio = Studio.find(params[:studio_id])
    if @studio.is_location_set == true
      render :json => {"lat" => @studio.lat, "lng" => @studio.lng}
    else
      render :json => {"error" => "no coords set"}
    end
  end
  
  def search
    studios_at_location = []
    valid_studios = Studio.where(is_location_set: true)
    for studio in valid_studios
      if studio.lat.between?(params[:s].to_f, params[:n].to_f) and studio.lng.between?(params[:w].to_f, params[:e].to_f)
        studios_at_location.push(studio)
      end
    end
    if params[:json] == "true"
      render :json => studios_at_location
    else
      render :partial => "studios_in_bounds", :locals => {:studios => studios_at_location}
    end
  end

  def get_all_studios
    @studios = Studio.all
    respond_to do |format|
      format.json{ render json: @studios}
    end
  end

  def get_search_studios
    if params[:query ].blank?
      @results = Studio.limit(20)
    else
      @results = Studio.where("name LIKE ? OR description LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").limit(20)
    end
    respond_to do |format|
      format.json{render json: @results}
    end
  end

  # *** HELPER METHODS
  private

    def create_membership
      m_params = {:studio_id => @studio.id, :is_admin => true, :member_id => current_user.id, :created_at => @studio.created_at, :updated_at => @studio.updated_at}
      membership = Membership.new(m_params)
      membership.save
    end
  
    def get_studio
      if params[:studio_id].blank? && params[:id].blank?
        raise ActionController::RoutingError.new('Not Found')
      elsif params[:id].blank?
        @studio = Studio.find(params[:studio_id])
      else
        @studio = Studio.find(params[:id])
      end 
    end
    
    

    def upload_photo(s_params, id, photo_path)
      if photo_path.nil?
        return
      end
      uploaded_io = photo_path
      extension = File.extname(uploaded_io.original_filename)
      filename = Rails.root.join('public', 'images', 'uploads', 'studios', id + extension)
      File.open(filename, 'wb')  do |file|
        file.write(uploaded_io.read)
      end
      s_params[:photo_path] = '/uploads/studios/' + id + extension
    end
    
    def studio_params 
      params.require(:studio).permit(:tag_list, :photo_path, :name, :description, :fb_url, :twtr_username, 
                                     :yt_username, :ig_url, :website_url, :email, 
                                     :phone_area_code, :phone_1, :phone_2,
                                     :address_line1, :address_line2, :city, :state, :zip_code,
                                     :lat, :lng, :is_location_set)
    end

end

















