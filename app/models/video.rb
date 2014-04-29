class Video < ActiveRecord::Base

  # *** ASSOCIATION *** #
  belongs_to :user

  def owned_by?(user)
    p self.user_id
    p user.id
    self.user_id == user.id
  end
  
end
