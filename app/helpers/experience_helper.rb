module ExperienceHelper
  def get_url(link)
    if link.collab_type == "user"
      get_user_url(link)
    end
  end

  def get_title(link)
    if link.collab_type == "user"
      get_user_title(link)
    end
  end

  def get_user_title(link)
    user = User.find(link.collab_id)
    get_user_full_name(user)
  end

  def get_user_full_name(user)
    user.first_name + " " + user.last_name
  end
  
  def get_user_url(link)
    "/users/" + link.collab_id.to_s
  end
end
