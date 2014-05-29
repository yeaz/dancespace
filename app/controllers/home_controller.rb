class HomeController < ApplicationController
  
  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index, :about]
  
  def search
    @results = ThinkingSphinx.search params[:query], :classes => [User, Studio, Video, Event]
  end
    
end
