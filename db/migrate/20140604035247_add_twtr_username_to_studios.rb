class AddTwtrUsernameToStudios < ActiveRecord::Migration
  def change
    add_column :studios, :twtr_username, :string
  end
end
