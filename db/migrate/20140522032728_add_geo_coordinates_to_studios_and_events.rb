class AddGeoCoordinatesToStudiosAndEvents < ActiveRecord::Migration
  def change
    add_column :studios, :lat, :float 
    add_column :studios, :lng, :float
    add_column :studios, :is_location_set, :boolean
    add_column :events, :lat, :float 
    add_column :events, :lng, :float
    add_column :events, :is_location_set, :boolean
  end
end
