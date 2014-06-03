class RemoveYtUrlFromStudios < ActiveRecord::Migration
  def change
    remove_column :studios, :yt_url
  end
end
