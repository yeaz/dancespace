class Video < ActiveRecord::Base

  # *** ASSOCIATION *** #
  belongs_to :user
  
  # *** VALIDATIONS *** #
  # TO-DO: Implement validations for video model 

  def owned_by?(user)
    self.user_id == user.id
  end
  
end
