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
end
