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
  has_many :experiencelinks, as: :collab
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  validates :username, :email, :password, :password_confirmation, :first_name, :last_name, :presence => true, on: :create
  validates :username, :email, :uniqueness => true, on: :create
  validates :password, :confirmation => true, on: :create
  validates_length_of :password, :within => Devise.password_length, on: :create

  validates_length_of :blurb, maximum: 2000, message: "Your blurb needs to be 2000 characters or less"
  validates_length_of :title, maximum: 500, message: "Your title needs to be 500 characters or less"

  validate :check_phone_number, on: :update

  def check_phone_number
    if phone_area_code == "" and phone_1 == "" and phone_2 == ""
      return
    elsif phone_area_code == "" or phone_1 == "" or phone_2 == ""
      errors.add(:phone, "Incomplete phone number")
    elsif !numeric?(phone_area_code, 3) or !numeric?(phone_1, 3) or !numeric?(phone_2, 4)
      errors.add(:phone, "Invalid phone number. Use format: XXX-XXX-XXXX")
    end
  end

  def numeric?(num, length)
    match = /[0-9]+/.match(num)
    if !match.nil?
      if match[0].length == length
        return true
      end
    end
    return false
  end

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

  def get_full_name
    return first_name + " " + last_name
  end

  def get_profile_url
    return '/users/' + id.to_s
  end
  
end
