class AddCollabNameToExperiencelinks < ActiveRecord::Migration
  def change
    add_column :experiencelinks, :collab_name, :string, default: ""
  end
end
