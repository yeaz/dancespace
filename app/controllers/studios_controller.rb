class StudiosController < ApplicationController

  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index]
  before_action :get_studio, only: [:edit, :update, :show, :destroy]
  
  def index
    @studios = Studio.search params[:search]
  end
  
  def new
    @studio = Studio.new
  end
  
  def create
    @studio = Studio.new(studio_params)
    if @studio.save
      create_membership
      redirect_to studio_path(@studio)
    else
      render 'new'
    end
  end
    
  def update
    s_params = studio_params
    if @studio.update_attributes(s_params)
      redirect_to studio_path(@studio)
    else
      render 'edit'
    end
  end
  
  def destroy
  end

  def nearby
    @studios = Studio.all
  end

  def show
    @events = Event.where("studio_id = ?",  params[:id])
  end

  def set_location
    @studio = Studio.find(params[:studio_id])
  end

  def set_coordinates
    puts 'PARAMS'
    @studio = Studio.find(params[:studio_id])
    if @studio.is_location_set.nil?
      puts 'is nil'
    end
    @studio.update(is_location_set: params[:set])
    if params.has_key?(:lat)
      @studio.update({lat: params[:lat].to_f, lng: params[:lng].to_f})
    end
    render :json => {"success" => "true"}
  end

  def get_address
    @studio = Studio.find(params[:studio_id])
    if @studio.is_location_set.nil?
      render :json => {"address" => @studio.get_address}
    elsif @studio.is_location_set == true
      render :json => {"lat" => @studio.lat, "lng" => @studio.lng}
    elsif @studio.is_location_set == false
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
    render :partial => "studios_in_bounds", :locals => {:studios => studios_at_location}
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
    
    def studio_params 
      params.require(:studio).permit(:name, :description, :fb_url, :twtr_url, 
                                     :yt_url, :ig_url, :website_url, :email, 
                                     :phone_area_code, :phone_1, :phone_2,
                                     :address_line1, :address_line2, :city, :state, :zip_code,
                                     :lat, :lng, :is_location_set)
    end
  
end

















