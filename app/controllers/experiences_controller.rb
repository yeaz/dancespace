class ExperiencesController < ApplicationController
  def new
    @experience = Experience.new
    @experience.experiencelinks.build
  end

  def create
    e_params = experience_params
    e_params[:user_id] = current_user.id
    update_collab_type(e_params)
    update_collab_id(e_params)
    @experience = Experience.new(e_params)
    @experience.save!
    redirect_to root_path
  end

  
  private

  def experience_params
    params.require(:experience).permit(:content, :experiencelinks_attributes =>
                                       [:id, :collab_id, :collab_type])
  end

  def update_collab_id(e_params)
    collab_type = get_collab_attribute(e_params, :collab_type)
    username = get_collab_attribute(e_params, :collab_id)
    if collab_type == "user"
      # changing the currently entered username to that user's id
      user = User.find_by(username: username)
      set_collab_attribute(e_params, user.id, :collab_id)
    end
  end

  def get_collab_attribute(e_params, attribute)
    return e_params[:experiencelinks_attributes]["0"][attribute]
  end

  def set_collab_attribute(e_params, value, attribute)
    e_params[:experiencelinks_attributes]["0"][attribute] = value
  end
  
  def update_collab_type(e_params)
    collab_type = get_collab_attribute(e_params, :collab_type)
    if collab_type == "dancer"
      collab_type = "user"
    end
    set_collab_attribute(e_params, collab_type, :collab_type)
  end
end
