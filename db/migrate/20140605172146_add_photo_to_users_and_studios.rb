class AddPhotoToUsersAndStudios < ActiveRecord::Migration
  def change
    add_column :users, :photo_path, :string
    add_column :studios, :photo_path, :string
  end
end
