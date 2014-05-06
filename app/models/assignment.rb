class Assignment < ActiveRecord::Base

  # *** ASSOCIATION *** #
  belongs_to :user
  belongs_to :role
  
end
