class AddZipCodes < ActiveRecord::Migration
  def change
    add_column :studios, :zip_code, :string
    add_column :events, :zip_code, :string
  end
end
