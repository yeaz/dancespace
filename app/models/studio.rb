class Studio < ActiveRecord::Base

  # *** ASSOCIATIONS *** #
  has_many :members, class_name: 'User', through: :studio_membership
  has_many :memberships, dependent: :destroy

  # Relationship between Studio and Experiencelink
  # :collab means that the model can be a collaborator for an
  # experiencelink
  has_many :experiencelinks, as: :collab
  
  # *** VALIDATIONS *** #
  validates :name, presence: { message: 'Please provide a name' }
  validates :description, presence: { message: 'Please provide a description' }
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
                              message: 'Please provide a valid email address' }
end
