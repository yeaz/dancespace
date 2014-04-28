class Role < ActiveRecord::Base
  
  # *** ASSOCIATION *** #
  
  # Relationship model between User and Role
  has_many :assignments, dependent: :destroy 
  
  has_many :users, :through => :assignments
  
end
