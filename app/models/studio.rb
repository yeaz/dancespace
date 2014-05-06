class Studio < ActiveRecord::Base

  # *** ASSOCIATIONS *** #
  has_many :members, class_name: 'User', through: :studio_membership
  has_many :memberships, dependent: :destroy
  
end
