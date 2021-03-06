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

  def get_facebook_page_id(url, graph)
    if url[-1] == '/'
      url = url[0, url.length - 1]
    end
    id = url.split('/')[-1]
    if id.nil? or id == ""
      return nil
    end
    page_obj = graph.get_object(id)
    if page_obj.nil?
      return nil
    end
    page_obj["id"]
  end

  # returns an array of post hashes, nil if there is no fb url for
  # this studio
  def get_facebook_posts(studio)
    puts 'FACEBOOK'
    begin
      graph = Koala::Facebook::API.new(facebook_api_key)
      if studio.fb_url.nil? or studio.fb_url == ""
        return nil
      end
      facebook_page_id = get_facebook_page_id(studio.fb_url, graph)
      puts facebook_page_id
      posts = graph.get_connections(facebook_page_id, "feed")
      posts = posts.select{ |post| filter_own_posts(post, facebook_page_id)}
      return posts[0,5]
    rescue
      return -1
    end
  end

  def get_ig_username(url)
    if url[-1] == '/'
      url = url[0, url.length - 1]
    end
    username =  url.split('/')[-1]
    if username.nil? or username == ""
      return nil
    end
    return username
  end
  
  def get_instagram_photos(studio)
    Instagram.configure do |config|
      config.client_id = "06a126d0eaf645ae8fa415742b4674c9"
      config.client_secret = "599a2ffff7414dc78a08f0d34d207e7a"
    end
    if studio.ig_url.nil? or studio.ig_url == ""
      return nil
    end
    begin
      username = get_ig_username(studio.ig_url)
      user_obj = Instagram.user_search(username)
      if user_obj.nil? or user_obj.length == 0
        return nil
      end
      ig_id = user_obj[0]["id"]
      pictures = Instagram.user_recent_media(ig_id, {count: 10}) # change the # of photos to get here
      urls = get_photo_urls(pictures)
      return urls[0,5]
    rescue
      return -1
    end
  end

  def get_photo_urls(pictures)
    return pictures.map{ |pic| pic["link"] }
  end

  def get_studio_profile_pic(photo_path)
    if photo_path.nil? or photo_path == ""
      return image_tag "studio1.jpg"
    else
      path = '<img src="/images/' + photo_path + '"/>'
      return path.html_safe
    end
  end

  
  def get_tweets(studio, field_name)
    handle = studio.send(field_name)
    if handle.blank?
      return nil
    end
    begin
      tweets = []
      puts 'TWITTER'
      puts handle
      # Authorization header with Twitter API bearer token
      twtr_auth_header='Bearer AAAAAAAAAAAAAAAAAAAAADRrWQAAAAAApUt6lWbEy4UE1wOZdDpGOruYyZ4%3DfoxWCyjFFURIDxrOjMuAVHKvkoMHrKnQH9dtMqKVBfAKAP4gyF'
      # Twitter Status API URL 
      twtr_status_api_url='https://api.twitter.com/1.1/statuses/user_timeline.json'
      # Twitter Oembed API URL
      twtr_oembed_api_url='https://api.twitter.com/1/statuses/oembed.json?'
      
      # Twitter Status API params
      status_params = {:screen_name => handle, 
        :count => 5, 
        :exclude_replies => true}
      
      # Send Twitter Search API request
      response = RestClient.get twtr_status_api_url, 
      :params => status_params, 
      :authorization => twtr_auth_header
      
      if response.code == 200
        json = JSON.parse(response)
        for tweet in json
          request_url = twtr_oembed_api_url + 'id=' + tweet['id_str']
          response = RestClient.get request_url
          
          if response.code == 200
            json = JSON.parse(response)
            tweets << json['html']
          end
        end
      end
      tweets
    rescue
      return -1
    end
  end

    
    def get_youtube_api_response(studio, maxResults = 5, pageToken = '', field_name)
      puts 'YOUTUBE'
      puts field_name
      
      username = studio.send(field_name)
      if username.blank?
        return nil
      end
      begin
      prevPageToken = ''
      nextPageToken = ''
      items = []
      
      # Google API Key
      google_api_key = 'AIzaSyC4WCykK27pFFElrwy72AvUDWS812e0DKk'
      # Youtube Channel API URL 
      youtube_channel_api_url = 'https://www.googleapis.com/youtube/v3/channels'
      # Youtube Playlist API URL
      youtube_playlist_api_url = 'https://www.googleapis.com/youtube/v3/playlistItems'
    
      # Channel API params
      channel_params = { :part => 'contentDetails',
                 :forUsername => username,
                 :key => google_api_key }
                 
      channel_response = RestClient.get youtube_channel_api_url,
                                        :params => channel_params
    
      if channel_response.code == 200
        json = JSON.parse(channel_response)
        uploads_playlist_id = json['items'][0]['contentDetails']['relatedPlaylists']['uploads']
        if !uploads_playlist_id.blank?
          # Playlist API params 
          playlist_params = { :part => 'contentDetails',
                              :playlistId => uploads_playlist_id,
                              :maxResults => maxResults,
                              :pageToken => pageToken,
                              :key => google_api_key }
                              
          playlist_response = RestClient.get youtube_playlist_api_url,
                                    :params => playlist_params
          
          if playlist_response.code == 200
            json = JSON.parse(playlist_response)
            prevPageToken = json['prevPageToken']
            nextPageToken = json['nextPageToken']
            for item in json['items']
              items << item['contentDetails']['videoId']
            end
          end
        end
      end
      { :prevPageToken => prevPageToken, 
       :nextPageToken => nextPageToken, 
       :items => items }
      rescue
      return -1
      end
    end
end
