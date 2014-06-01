module UsersHelper
  # makes the icon a link if the url isn't blank, and no link if
  # the url is blank
  def make_contact_icon(url, img)
    if url != ""
      link = '<a href="' + url + '" target="_blank">' + image_tag(img) + '</a>'
    else
      link = image_tag(img)
    end
    link.html_safe
  end

  def fix_contact_urls(u_params)
    update_contact_param(:fb_url, u_params)
    update_contact_param(:yt_url, u_params)
    update_contact_param(:ig_url, u_params)
    update_contact_param(:twtr_url, u_params)
    return u_params
  end

  def update_contact_param(param, u_params)
    e = /\Ahttp[s]?:\/\//
    to_add = "http://"
    if u_params.key?(param) and u_params[param] != "" and e.match(u_params[param]).nil?
      u_params[param] = to_add + u_params[param].strip
    end
  end

end
