class UpdateDefaultUserContactInfo < ActiveRecord::Migration
  def change
    change_column_default :users, :fb_url, ""
    change_column_default :users, :yt_url, ""
    change_column_default :users, :ig_url, ""
    change_column_default :users, :twtr_url, ""
    
  end
end
