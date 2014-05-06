class Membership < ActiveRecord::Base

  # *** ASSOCIATIONS *** #
  belongs_to :member, class_name: "User"
  belongs_to :studio
  
end
