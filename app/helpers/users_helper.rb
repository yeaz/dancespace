module UsersHelper
  def get_user_profile_url(user)
    return '/users/' + user.id.to_s
  end
end
