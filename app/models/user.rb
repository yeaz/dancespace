class User < ActiveRecord::Base

  # *** ASSOCIATION *** #
  
  has_many :videos, dependent: :destroy 
  
  # Relationship model between User and Role
  has_many :assignments, dependent: :destroy 
  
  has_many :roles, through: :assignments
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
         
  # *** VALIDATIONS *** #
  validates :username, :email, :password, :password_confirmation, :first_name, :last_name, :presence => true
  validates :username, :email, :uniqueness => true
  validates :password, :confirmation => true
  validates_length_of :password, :within => Devise.password_length
  
  
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
