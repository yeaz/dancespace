class AddAddressToStudio < ActiveRecord::Migration
  def change
    add_column :studios, :address_line1, :text, null: false
    add_column :studios, :address_line2, :text
    add_column :studios, :city, :text, null: false
    add_column :studios, :state, :text, null: false
  end
end
