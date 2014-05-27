class HomeController < ApplicationController
  
  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index, :about]
  
  def index
    @videos = Video.all
  end

  def eventsfeed
  	render :partial => "home/eventsfeed"
  end

  def studiosnearby
  	render :partial => "home/studiosnearby"
  end
  
end
