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

  def get_studio_owner(studio_id)
    membership = Membership.where("studio_id = ? and is_admin = ?", studio_id, true)
    if membership.nil?
      return nil
    end
    return User.find(membership.first.member_id)
  end

  def us_states
    [
     ['Select a state', nil],
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

  def facebook_api_key
    "503105699818951|jXz0mBSJ8c1OpYEBxQxRBh0gkoY"
  end

  def filter_own_posts(post, facebook_page_id)
    if post["from"]["id"] == facebook_page_id.to_s
      return post
    else
      return nil
    end
  end

  # def split_post_id(post_id) # post_id e.g 0483888393_393948293489
  #   re = /([0-9]+)_([0-9]+)/
  #   match = re.match(post_id)
  #   if match.nil?
  #     return nil
  #   end
  #   return [match[1], match[2]]
  # end

  # def make_result(post)
  #   id = post["id"]
  #   first, second = split_post_id(id)
  #   return [post, first, second]
  # end
  # https://www.facebook.com/pages/THE-PALACE-DANCE-STUDIO/84591582635

  def get_facebook_page_id(url, graph)
    if url[-1] == '/'
      url = url[0, url.length - 1]
    end
    id = url.split('/')[-1]
    page_obj = graph.get_object(id)
    if page_obj.nil?
      nil
    end
    page_obj["id"]
  end

  # returns an array of post hashes, nil if there is no fb url for
  # this studio
  def get_facebook_posts(studio)
    puts 'FACEBOOK'
    graph = Koala::Facebook::API.new(facebook_api_key)
    if studio.fb_url.nil?
      return nil
    end
    facebook_page_id = get_facebook_page_id(studio.fb_url, graph)
    puts facebook_page_id
    posts = graph.get_connections(facebook_page_id, "feed")
    posts = posts.select{ |post| filter_own_posts(post, facebook_page_id)}
    # posts = posts.select{ |post| make_result(post) }
    puts posts.length
    puts posts
    return posts
  end
end
