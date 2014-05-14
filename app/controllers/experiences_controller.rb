class ExperiencesController < ApplicationController
  def new
    puts 'NEW LINK'
    @experience = Experience.new
    @experience.experiencelinks.build
  end

  def create
    e_params = experience_params
    e_params[:user_id] = current_user.id
    collab_type = e_params[:experiencelinks_attributes]["0"][:collab_type]
    if collab_type == "dancer"
      collab_type = "user"
    end
    e_params[:experiencelinks_attributes]["0"][:collab_type] = collab_type
    @experience = Experience.new(e_params)
    @experience.save!
    redirect_to root_path
  end

  
  private

  def experience_params
    params.require(:experience).permit(:content, :experiencelinks_attributes =>
                                       [:id, :collab_id, :collab_type])
  end
end
