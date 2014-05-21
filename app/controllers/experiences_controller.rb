class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    @experience.experiencelinks.build
  end

  def create
    flash[:experience_errors] = {}
    e_params = experience_params
    e_params[:user_id] = current_user.id
    no_errors = update_collab(e_params)
    if no_errors == true
      @experience = Experience.new(e_params)
      @experience.save
      if @experience.errors.any?
        @experience.errors.each do |attribute, error|
          flash[:experience_errors][attribute] = error
        end
      end
    else
      no_errors.each do |k, v|
        flash[:experience_errors][k] = v
      end
    end
    
    redirect_to '/user_settings'
  end

  
  private

  def experience_params
    params.require(:experience).permit(:content, :experiencelinks_attributes =>
                                       [:id, :collab_id, :collab_type])
  end

  def update_collab(e_params)
    collab_type = get_collab_attribute(e_params, :collab_type)
    if collab_type != "Select one"
      update_collab_type(e_params, collab_type)
      no_errors = update_collab_id(e_params)
      if no_errors == true
        return true
      else
        return no_errors
      end
      
    else
      e_params.delete(:experiencelinks_attributes)
      return true
    end
  end
  
  def update_collab_id(e_params)
    collab_type = get_collab_attribute(e_params, :collab_type)
    collab_id = get_collab_attribute(e_params, :collab_id)
    if collab_type == "user"
      # changing the currently entered username to that user's id
      user = User.find_by(username: collab_id)
      if !user.nil?
        set_collab_attribute(e_params, user.id, :collab_id)
        return true
      else
        return {:collab_id => "Enter a valid username"}
      end
    elsif collab_type == "studio"
      studio = Studio.find_by(name: collab_id)
      if !studio.nil?
        set_collab_attribute(e_params, studio.id, :collab_id)
      else
        set_collab_attribute(e_params, -1, :collab_id)
        set_collab_attribute(e_params, collab_id, :collab_name)
      end
      return true
    end
  end

  def get_collab_attribute(e_params, attribute)
    return e_params[:experiencelinks_attributes]["0"][attribute]
  end

  def set_collab_attribute(e_params, value, attribute)
    e_params[:experiencelinks_attributes]["0"][attribute] = value
  end
  
  def update_collab_type(e_params, collab_type)
    if collab_type == "dancer"
      collab_type = "user"
    end
    set_collab_attribute(e_params, collab_type, :collab_type)
  end
end
