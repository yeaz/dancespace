class SeparateDateTimeForEvents < ActiveRecord::Migration
  def change
    remove_column :events, :event_date_time
    add_column :events, :event_date, :date
    add_column :events, :event_time, :time
  end
end
