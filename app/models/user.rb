class User < ActiveRecord::Base

  # *** ASSOCIATION *** #
  acts_as_taggable_on :styles
  has_many :videos, dependent: :destroy 
  
  # Relationship model between User and Role
  has_many :assignments, dependent: :destroy 
  
  has_many :roles, through: :assignments

  # Relationship model between User and Experience
  has_many :experiences

  # Relationship between User and Experiencelink
  # :collab means that the model can be a collaborator for an
  # experiencelink
  has_many :experience_links, as: :collab
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  validates :username, :email, :password, :password_confirmation, :first_name, :last_name, :presence => true, on: :create
  validates :username, :email, :uniqueness => true, on: :create
  validates :password, :confirmation => true, on: :create
  validates_length_of :password, :within => Devise.password_length, on: :create
  
  
  # *** METHODS *** #
  
  # Determines if the user has the role indicated by the given input.
  #
  # @param [Symbol] Role name
  # @return [Boolean] True if the user has the given input as role, false otherwise.
  # @author yeaz
  # @example
  #   if user.has_role? :admin
  #     can :manage, :all
  #   end
  #
  # @see https://github.com/ryanb/cancan/wiki/Separate-Role-Model
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  
end
