class Event < ActiveRecord::Base

  include EventsHelper
  # *** ASSOCIATIONS *** #
  belongs_to :studio

  acts_as_taggable_on :tags

  # VALIDATIONS
  validates :name, :description, :address_line1, :city, :state, :zip_code, :presence => true
  validates :event_date, :event_time, :presence => true
  validate :event_date_cannot_be_in_past

  def event_date_cannot_be_in_past
    pst = 'Pacific Time (US & Canada)'
    event_date_time = make_date_time(event_date, event_time)
    if event_date_time < DateTime.now.in_time_zone(pst)
      errors.add(:event_date_time, "Event date and time can't be in the past")
    end
  end

  def get_address
    return address_line1 + ' ' + address_line2 + ', ' + city + ' ' + state + ' ' + zip_code
  end
end
