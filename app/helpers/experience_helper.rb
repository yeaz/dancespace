module ExperienceHelper
  def get_url(link)
    if link.collab_type == "user"
      get_user_url(link)
    elsif link.collab_type == "studio"
      get_studio_url(link)
    end
  end

  def get_title(link)
    if link.collab_type == "user"
      get_user_title(link)
    elsif link.collab_type == "studio"
      get_studio_title(link)
    end
  end

  def get_studio_title(link)
    studio = Studio.find(link.collab_id)
    return studio.name
  end
  
  def get_user_title(link)
    user = User.find(link.collab_id)
    return user.get_full_name
  end

  def get_user_url(link)
    "/users/" + link.collab_id.to_s
  end

  def get_studio_url(link)
    "/studios/" + link.collab_id.to_s
  end

  def construct_a_tag(link)
    '<a href="' + get_url(link) + '">' +
      get_title(link) + '</a>'
  end

  def construct_div_tag(link)
    '<div>' + link.collab_name + '</div>'
  end

  def get_collab_field(link)
    if link.collab_id != -1
      construct_a_tag(link).html_safe
    else
      construct_div_tag(link).html_safe
    end
  end
end
