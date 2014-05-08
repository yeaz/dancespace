class Video < ActiveRecord::Base

  # *** ASSOCIATION *** #
  belongs_to :user
  acts_as_taggable_on :tags
  
  # *** VALIDATIONS *** #
  # TO-DO: Implement validations for video model 

  def owned_by?(user)
    self.user_id == user.id
  end
  
end
