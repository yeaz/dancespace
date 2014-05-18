class EventsController < ApplicationController

  # *** FILTERS *** #
  before_action :get_events, only: [:edit, :update, :show, :destroy]
  before_action :get_studio, only: [:index, :new, :create]
  
  def new
    @event = Event.new
  end
  
  def create
    e_params = event_params
    update_date_time(e_params)
    @event = Event.new(e_params)
    @event.studio = @studio
    if @event.save
      redirect_to event_path(@event)
    else
      add_errors_to_flash
      render 'new'
    end
  end
  
  def update
    e_params = event_params
    update_date_time(e_params)
    if @event.update_attributes(e_params)
      redirect_to event_path(@event)
    else
      add_errors_to_flash
      render 'edit'
    end
  end


  def index
  end

  
  def destroy
  end
  
  # *** HELPER METHODS *** #
  private

  def add_errors_to_flash
    flash[:event_errors] = {}
    @event.errors.each do |k, v|
      flash[:event_errors][k] = v
    end
  end

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
      params.require(:event).permit(:name, :description, :address_line1, :address_line2, :city, :state, :event_date_time)
    end
  
end
