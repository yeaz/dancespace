class AddContactInfoToUsersAndStudios < ActiveRecord::Migration
  def change
    # USERS
    add_column :users, :fb_url, :string
    add_column :users, :twtr_url, :string
    add_column :users, :yt_url, :string
    add_column :users, :ig_url, :string
    add_column :users, :website_url, :string
    add_column :users, :phone_area_code, :string, default: ""
    add_column :users, :phone_1, :string, default: ""
    add_column :users, :phone_2, :string, default: ""
    
    # STUDIOS
    add_column :studios, :fb_url, :string
    add_column :studios, :twtr_url, :string
    add_column :studios, :yt_url, :string
    add_column :studios, :ig_url, :string
    add_column :studios, :website_url, :string
    add_column :studios, :email, :string
    add_column :studios, :phone_area_code, :string, default: ""
    add_column :studios, :phone_1, :string, default: ""
    add_column :studios, :phone_2, :string, default: ""
  end
end
