module EventsHelper
  def get_pst_time(datetime)
    zone = ActiveSupport::TimeZone.new("Pacific Time (US & Canada)")
    newtime = datetime.in_time_zone(zone)
    return newtime
  end

  def get_event_profile_pic(photo_path)
    if photo_path.nil? or photo_path == ""
      return image_tag "studio1.jpg"
    else
      path = '<img src="/images/' + photo_path + '"/>'
      return path.html_safe
    end
  end
end
