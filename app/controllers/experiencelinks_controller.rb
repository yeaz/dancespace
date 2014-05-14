class ExperiencelinksController < ApplicationController
  before_action :set_experiencelink, only: [:show, :edit, :update, :destroy]

  # GET /experiencelinks
  # GET /experiencelinks.json
  def index
    @experiencelinks = Experiencelink.all
  end

  # GET /experiencelinks/1
  # GET /experiencelinks/1.json
  def show
  end

  # GET /experiencelinks/new
  def new
    @experiencelink = Experiencelink.new
  end

  # GET /experiencelinks/1/edit
  def edit
  end

  # POST /experiencelinks
  # POST /experiencelinks.json
  def create
    @experiencelink = Experiencelink.new(experiencelink_params)

    respond_to do |format|
      if @experiencelink.save
        format.html { redirect_to @experiencelink, notice: 'Experiencelink was successfully created.' }
        format.json { render action: 'show', status: :created, location: @experiencelink }
      else
        format.html { render action: 'new' }
        format.json { render json: @experiencelink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiencelinks/1
  # PATCH/PUT /experiencelinks/1.json
  def update
    respond_to do |format|
      if @experiencelink.update(experiencelink_params)
        format.html { redirect_to @experiencelink, notice: 'Experiencelink was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @experiencelink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiencelinks/1
  # DELETE /experiencelinks/1.json
  def destroy
    @experiencelink.destroy
    respond_to do |format|
      format.html { redirect_to experiencelinks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiencelink
      @experiencelink = Experiencelink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiencelink_params
      params[:experiencelink]
    end
end
