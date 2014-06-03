class AddYtUsernameToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :yt_username, :string
  end
end
