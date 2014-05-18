class Event < ActiveRecord::Base

  # *** ASSOCIATIONS *** #
  belongs_to :studio

  # VALIDATIONS
  validates :name, :description, :address_line1, :city, :state, :presence => true
  validate :event_date_cannot_be_in_past, on: :create

  def event_date_cannot_be_in_past
    pst = 'Pacific Time (US & Canada)'
    if event_date_time < DateTime.now.in_time_zone(pst)
      errors.add(:event_date_time, "Can't be in the past")
    end
  end
end
