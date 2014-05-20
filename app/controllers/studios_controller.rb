class StudiosController < ApplicationController

  # *** FILTERS *** #
  skip_before_action :authentication_user!, only: [:index]
  before_action :get_studio, only: [:edit, :update, :show, :destroy]
  
  def index
    @studios = Studio.all
  end
  
  def new
    @studio = Studio.new
  end
  
  def create
    @studio = Studio.new(studio_params)
    if @studio.save
      redirect_to studio_path(@studio)
    else
      render 'new'
    end
  end
    
  def update
    if @studio.update_attributes(studio_params)
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

  # *** HELPER METHODS *** #
  private
  
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
                                     :phone_area_code, :phone_1, :phone_2)
    end
  
end
