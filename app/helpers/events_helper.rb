module EventsHelper
  def get_pst_time(datetime)
    zone = ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
    newtime = datetime.in_time_zone(zone)
    return newtime
  end
end
