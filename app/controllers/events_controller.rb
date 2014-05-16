class EventsController < ApplicationController

  # *** FILTERS *** #
  before_action :get_events, only: [:edit, :update, :show, :destroy]
  before_action :get_studio, only: [:index, :new, :create]
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_params)
    @event.studio = @studio
    if @event.save
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end
  
  def update
    if @event.update_attributes(event_params)
      redirect_to event_path(@event)
    else
      render 'edit'
    end
  end
   
  def destroy
  end
  
  # *** HELPER METHODS *** #
  private
  
    def get_events
      if params[:event_id].blank? && params[:id].blank?
        raise ActionController::RoutingError.new('Not Found')
      elsif params[:id].blank?
        @event = Event.find(params[:event_id])
      else
        @event = Event.find(params[:id])
      end 
    end
    
    def get_studio
      if params[:studio_id].blank?
        raise ActionController::RoutingError.new('Not Found')
      else
        @studio = Studio.find(params[:studio_id])
      end
    end
    
    def event_params 
      params.require(:event).permit(:name, :description)
    end
  
end
