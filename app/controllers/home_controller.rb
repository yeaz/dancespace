class HomeController < ApplicationController
  
  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index, :about]
  
  def search
    @results = ThinkingSphinx.search params[:query], :classes => [User, Studio, Video, Event]
  end

  def eventsfeed
  #	render :partial => "home/eventsfeed"
    render :partial => "home/events_near_you"
  end

  def load_eventsfeed_title
    render :partial => "home/eventsfeed_title"
  end

  def load_studiosfeed_title
    render :partial => "home/studiosfeed_title"
  end

  def studiosnearby
  	render :partial => "home/studiosnearby"
  end
  
end
