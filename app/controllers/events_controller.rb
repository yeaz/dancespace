class EventsController < ApplicationController

  include StudioHelper
  include EventsHelper
  
  # *** FILTERS *** #
  skip_before_action :authenticate_user!, only: [:index]
  before_action :get_events, only: [:edit, :update, :show, :destroy]
  before_action :get_studio, only: [:new, :create]
  
  def index
    @events = Event.limit(20)
  end

  def new
    if !current_user_owns_studio(params[:studio_id])
      redirect_to studio_path(params[:studio_id])
    end
    @event = Event.new
  end
  
  def create
    e_params = event_params
    photo_path = e_params[:photo_path]
    e_params.delete(:photo_path)
  #  update_date_time(e_params)
    @event = Event.new(e_params)
    @event.studio = @studio
    if @event.save
      upload_photo(e_params, @event.id.to_s, photo_path)
      @event.update(e_params)
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end
  
  def update
    e_params = event_params
  #  update_date_time(e_params)
    upload_photo(e_params, @event.id.to_s, e_params[:photo_path])
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

  def set_coordinates
    @event = Event.find(params[:event_id])
    @event.update(is_location_set: params[:set])
    if params.has_key?(:lat)
      @event.update({lat: params[:lat].to_f, lng: params[:lng].to_f})
    end
    render :json => {"success" => "true"}
  end

  def get_address
    @event = Event.find(params[:event_id])
    if @event.is_location_set == -1
      render :json => {"address" => @event.get_address}
    elsif @event.is_location_set == 1
      render :json => {"lat" => @event.lat, "lng" => @event.lng}
    elsif @event.is_location_set == 0
      render :json => {"error" => "true"}
    end
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
    @events = get_and_update_future_events(events_at_location)
    if params[:json] == "true"
      render :json => @events
    else
      render :partial => "events_in_bounds", :locals => {:events => @events}
    end
  end

  def get_and_update_future_events(events_at_location)
    future_events = []
    curr_time = DateTime.now
    for event in events_at_location
      event_date_time = make_date_time(event.event_date, event.event_time)
      if curr_time <= event_date_time
        future_events.push(event)
      end
    end
    return future_events
  end

  def destroy
  end

  def get_all_events
    @events = Event.all
    render :partial => "create_event_listing", :locals => {:events => @events}
  end

  def make_event_listing
    event = Event.find(params[:event_id])
    render :partial => "create_event_listing", :locals => {:e => event}
  end

   def get_search_events
    if params[:query].blank?
      @results = Event.limit(20)
    else
      @results = Event.where('name LIKE ? OR description LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%").limit(20) 
    end
    respond_to do |format|
      format.json{render json: @results}
    end
  end

  def get_search_events_only
    if params[:query].blank?
      @results = Event.limit(20)
    else
      @results = Event.where('name LIKE ? OR description LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%").limit(20) 
    end
    puts @results.length
    if @results.length == 0
      @results = []
    end
    render :partial => "create_event_listing", :locals => {:events => @results}
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

    def upload_photo(e_params, id, photo_path)
      if photo_path.nil?
        return
      end
      uploaded_io = photo_path
      extension = File.extname(uploaded_io.original_filename)
      filename = Rails.root.join('public', 'images', 'uploads', 'events', id + extension)
      File.open(filename, 'wb')  do |file|
        file.write(uploaded_io.read)
      end
      e_params[:photo_path] = '/uploads/events/' + id + extension
    end
    
    def event_params 
      params.require(:event).permit(:event_date, :event_time, :tag_list, :photo_path, :name, :description, :address_line1, :address_line2, :city, :state, :zip_code, :event_date_time, :lat, :lng, :is_location_set)
    end
  
end
