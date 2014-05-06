class AddYoutubeUrlToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :youtube_url, :text
  end
end
