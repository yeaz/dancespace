class EventsController < ApplicationController

  include StudioHelper
  
  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index]
  before_action :get_events, only: [:edit, :update, :show, :destroy]
  before_action :get_studio, only: [:new, :create]
  
  def index
    @events = Event.search params[:search]
  end

  def new
    if !current_user_owns_studio(params[:studio_id])
      redirect_to studio_path(params[:studio_id])
    end

    @event = Event.new
  end
  
  def create
    e_params = event_params
    update_date_time(e_params)
    @event = Event.new(e_params)
    @event.studio = @studio
    if @event.save
      redirect_to '/events/' + @event.id.to_s + '/set_location'
    else
      render 'new'
    end
  end
  
  def update
    e_params = event_params
    if e_params.has_key?(:lat) and e_params.has_key?(:lng)
      e_params[:is_location_set] = true
      @event.update_attributes(e_params)
      redirect_to event_path(@event)
      return
    end
    
    update_date_time(e_params)
    if @event.update_attributes(e_params)
      redirect_to event_path(@event)
    else
      render 'edit'
    end
  end

  def edit
    if !current_user_owns_studio(@event.studio_id)
      redirect_to event_path(@event)
    end
  end

  def get_address
    @event = Event.find(params[:event_id])
    if @event.is_location_set == false
      render :json => {"address" => @event.get_address}
    else
      render :json => {"lat" => @event.lat, "lng" => @event.lng}
    end
  end

  def set_location
    @event = Event.find(params[:event_id])
  end

  def get_coordinates
    @event = Event.find(params[:event_id])
    if @event.is_location_set == true
      render :json => {"lat" => @event.lat, "lng" => @event.lng}
    else
      render :json => {"error" => "no coords set"}
    end
  end

  # gets questions within the north, south, east, west boundaries
  def search
    events_at_location = []
    valid_events = Event.where(is_location_set: true)
    for event in valid_events
      if event.lat.between?(params[:s].to_f, params[:n].to_f) and event.lng.between?(params[:w].to_f, params[:e].to_f)
        events_at_location.push(event)
      end
    end
    @questions = get_and_update_future_events(events_at_location)
    render :partial => "events_in_bounds", :locals => {:events => @questions}
  end

  def get_and_update_future_events(events_at_location)
    future_events = []
    curr_time = DateTime.now
    for event in events_at_location
      if curr_time <= event.event_date_time
        future_events.push(event)
      end
    end
    return future_events
  end

  def destroy
  end
  
  # *** HELPER METHODS *** #
  private

    def update_date_time(e_params)
      convert_datetimes_to_pst('event_date_time', e_params)
    end

    def convert_datetimes_to_pst(field, e_params)
      datetime = (1..5).collect {|num| e_params.delete "#{field}(#{num}i)" }
      if datetime[0] and datetime[1] and datetime[2] # only if a date has been set
        e_params[field] = Time.find_zone!("Pacific Time (US & Canada)").local(*datetime.map(&:to_i))
      end
    end

  
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
      params.require(:event).permit(:name, :description, :address_line1, :address_line2, :city, :state, :zip_code, :event_date_time, :lat, :lng)
    end
  
end
