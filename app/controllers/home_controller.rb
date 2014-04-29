class HomeController < ApplicationController
  
  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    @videos = Video.all
  end
  
end
