module StudioHelper
  def current_user_owns_studio(studio_id)
    membership = Membership.where("studio_id = ? and is_admin = ?", studio_id, true)
    if membership.nil?
      return false
    end
    memb = membership.first
    if memb.member_id == current_user.id
      return true
    end
    return false
  end
end
