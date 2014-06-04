class StudiosController < ApplicationController

  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index]
  before_action :get_studio, only: [:edit, :update, :show, :destroy, :get_all_yt_videos]

  include UsersHelper
  include StudioHelper
  
  def index
    @studios = Studio.search params[:search]
  end
  
  def new
    @studio = Studio.new
  end
  
  def create
    @studio = Studio.new(fix_contact_urls(studio_params))
    if @studio.save
      create_membership
      redirect_to studio_path(@studio)
    else
      render 'new'
    end
  end
    
  def update
    if @studio.update_attributes(fix_contact_urls(studio_params))
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
      response = get_youtube_api_response(@studio, 50, pageToken)
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
    if response.nil?
      @videos = nil
    else
      @videos = response[:items]
    end
    
    # Facebook
    @fb_posts = get_facebook_posts(@studio)
    
    # Twitter
    @tweets = get_tweets(@studio)
    
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
    
    def get_youtube_api_response(studio, maxResults = 5, pageToken = '') 
      if studio.yt_username.blank?
        return nil
      end
      
      prevPageToken = ''
      nextPageToken = ''
      items = []
      
      # Google API Key
      google_api_key = 'AIzaSyC4WCykK27pFFElrwy72AvUDWS812e0DKk'
      # Youtube Channel API URL 
      youtube_channel_api_url = 'https://www.googleapis.com/youtube/v3/channels'
      # Youtube Playlist API URL
      youtube_playlist_api_url = 'https://www.googleapis.com/youtube/v3/playlistItems'
    
      # Channel API params
      channel_params = { :part => 'contentDetails',
                 :forUsername => studio.yt_username,
                 :key => google_api_key }
                 
      channel_response = RestClient.get youtube_channel_api_url,
                                        :params => channel_params
    
      if channel_response.code == 200
        json = JSON.parse(channel_response)
        uploads_playlist_id = json['items'][0]['contentDetails']['relatedPlaylists']['uploads']
        if !uploads_playlist_id.blank?
          # Playlist API params 
          playlist_params = { :part => 'contentDetails',
                              :playlistId => uploads_playlist_id,
                              :maxResults => maxResults,
                              :pageToken => pageToken,
                              :key => google_api_key }
                              
          playlist_response = RestClient.get youtube_playlist_api_url,
                                    :params => playlist_params
          
          if playlist_response.code == 200
            json = JSON.parse(playlist_response)
            prevPageToken = json['prevPageToken']
            nextPageToken = json['nextPageToken']
            for item in json['items']
              items << item['contentDetails']['videoId']
            end
          end
        end
      end
      { :prevPageToken => prevPageToken, 
       :nextPageToken => nextPageToken, 
       :items => items }
    end
    
    def get_tweets(studio)
      if studio.twtr_username.blank?
        return nil
      end
      
      tweets = []
      
      # Authorization header with Twitter API bearer token
      twtr_auth_header='Bearer AAAAAAAAAAAAAAAAAAAAADRrWQAAAAAApUt6lWbEy4UE1wOZdDpGOruYyZ4%3DfoxWCyjFFURIDxrOjMuAVHKvkoMHrKnQH9dtMqKVBfAKAP4gyF'
      # Twitter Status API URL 
      twtr_status_api_url='https://api.twitter.com/1.1/statuses/user_timeline.json'
      # Twitter Oembed API URL
      twtr_oembed_api_url='https://api.twitter.com/1/statuses/oembed.json?'
      
      # Twitter Status API params
      status_params = {:screen_name => studio.twtr_username, 
                :count => 20, 
                :exclude_replies => true}
                
      # Send Twitter Search API request
      response = RestClient.get twtr_status_api_url, 
                               :params => status_params, 
                               :authorization => twtr_auth_header
      
      if response.code == 200
        json = JSON.parse(response)
        for tweet in json
          request_url = twtr_oembed_api_url + 'id=' + tweet['id_str']
          response = RestClient.get request_url
                                                                        
          if response.code == 200
            json = JSON.parse(response)
            tweets << json['html']
          end
        end
      end
      tweets
    end
    
    def studio_params 
      params.require(:studio).permit(:name, :description, :fb_url, :twtr_username, 
                                     :yt_username, :ig_url, :website_url, :email, 
                                     :phone_area_code, :phone_1, :phone_2,
                                     :address_line1, :address_line2, :city, :state, :zip_code,
                                     :lat, :lng, :is_location_set)
    end
  
end

















