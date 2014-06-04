class RemoveTwtrUrlFromStudios < ActiveRecord::Migration
  def change
    remove_column :studios, :twtr_url
  end
end
