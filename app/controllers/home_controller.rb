class HomeController < ApplicationController
  
  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index, :about]
  
  def search
    if params[:query].blank?
      @results = []
    else
      @results = []
      users = User.where('first_name LIKE ? OR last_name LIKE ? OR email LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%").limit(5)
      studios = Studio.where("name LIKE ? OR description LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").limit(5)
      events = Event.where('name LIKE ? OR description LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%").limit(5)
      for user in users
        @results << user
      end
      for studio in studios
        @results << studio
      end
      for event in events
        @results << event 
      end
    end
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
