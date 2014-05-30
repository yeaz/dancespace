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

  def us_states
    [
     ['AK', 'AK'],
     ['AL', 'AL'],
     ['AR', 'AR'],
     ['AZ', 'AZ'],
     ['CA', 'CA'],
     ['CO', 'CO'],
     ['CT', 'CT'],
     ['DC', 'DC'],
     ['DE', 'DE'],
     ['FL', 'FL'],
     ['GA', 'GA'],
     ['HI', 'HI'],
     ['IA', 'IA'],
     ['ID', 'ID'],
     ['IL', 'IL'],
     ['IN', 'IN'],
     ['KS', 'KS'],
     ['KY', 'KY'],
     ['LA', 'LA'],
     ['MA', 'MA'],
     ['MD', 'MD'],
     ['ME', 'ME'],
     ['MI', 'MI'],
     ['MN', 'MN'],
     ['MO', 'MO'],
     ['MS', 'MS'],
     ['MT', 'MT'],
     ['NC', 'NC'],
     ['ND', 'ND'],
     ['NE', 'NE'],
     ['NH', 'NH'],
     ['NJ', 'NJ'],
     ['NM', 'NM'],
     ['NV', 'NV'],
     ['NY', 'NY'],
     ['OH', 'OH'],
     ['OK', 'OK'],
     ['OR', 'OR'],
     ['PA', 'PA'],
     ['RI', 'RI'],
     ['SC', 'SC'],
     ['SD', 'SD'],
     ['TN', 'TN'],
     ['TX', 'TX'],
     ['UT', 'UT'],
     ['VA', 'VA'],
     ['VT', 'VT'],
     ['WA', 'WA'],
     ['WI', 'WI'],
     ['WV', 'WV'],
     ['WY', 'WY']
    ]
  end
end
