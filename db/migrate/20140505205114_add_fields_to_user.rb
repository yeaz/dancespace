class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :blurb, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :title, :string
  end
end
