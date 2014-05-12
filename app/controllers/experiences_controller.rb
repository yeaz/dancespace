class ExperiencesController < ApplicationController
  def create
    exp = Experience.new
    puts 'EXP P = ', experience_params
    exp.save!(experience_params)
    redirect_to root_path
  end

  private

  def experience_params
    params.require(:experience).permit(:id, :content)
  end
  
end
