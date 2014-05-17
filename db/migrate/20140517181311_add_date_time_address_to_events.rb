class AddDateTimeAddressToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_date_time, :datetime, null: false
    add_column :events, :address_line1, :text, null: false
    add_column :events, :address_line2, :text
    add_column :events, :city, :text, null: false
    add_column :events, :state, :text, null: false
  end
end
