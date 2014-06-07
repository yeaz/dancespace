class TagsController < ApplicationController
  def get_search_tags
      query = params[:query]
      @results = ActsAsTaggableOn::Tag.find_by_name(query);
      respond_to do |format|
        format.json{render json: @results}
      end
  end

  def show

  end

end
