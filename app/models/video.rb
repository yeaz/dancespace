class Video < ActiveRecord::Base

  # *** ASSOCIATION *** #
  belongs_to :user
  acts_as_taggable_on :tags

  def owned_by?(user)
    p self.user_id
    p user.id
    self.user_id == user.id
  end
  
end
