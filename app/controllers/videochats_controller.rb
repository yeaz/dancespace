class VideochatsController < ApplicationController

  before_action :get_videochat, only: [:edit, :update, :destroy, :show, :set_host_peer_id]
  
  def index
    @videochats = Videochat.all
  end
  
  def new
    @videochat = Videochat.new
  end
  
  def create
    @videochat = Videochat.new(videochat_params)
    @videochat.user = current_user
    
    if @videochat.save
      redirect_to videochat_path(@videochat)
    else
      render 'new'
    end
  end
  
  def update
    if @videochat.update_attributes(videochat_params)
      redirect_to videochat_path(@videochat)
    else 
      render 'edit'
    end
  end
    
  def destroy
    @videochat.destroy!
    redirect to videochats_path
  end
  
  def set_host_peer_id
    @videochat.host_peer_id = params[:host_peer_id]
    @videochat.save!
    respond_to do |format|
      format.json { render :json => { result: 'success' } }
    end
  end
  
  private
  
  def get_videochat
      if params[:videochat_id].blank? && params[:id].blank?
        raise ActionController::RoutingError.new('Not Found')
      elsif params[:id].blank?
        @videochat = Videochat.find(params[:videochat_id])
      else
        @videochat = Videochat.find(params[:id])
      end 
    end
    
    def videochat_params 
      params.require(:videochat).permit(:title)
    end
end
