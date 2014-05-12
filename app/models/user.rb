class User < ActiveRecord::Base

  # *** ASSOCIATION *** #
  has_many :videos
  acts_as_taggable_on :styles
  has_many :experiences
  accepts_nested_attributes_for :experiences
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  validates :username, :email, :password, :password_confirmation, :first_name, :last_name, :presence => true, on: :create
  validates :username, :email, :uniqueness => true, on: :create
  validates :password, :confirmation => true, on: :create
  validates_length_of :password, :within => Devise.password_length, on: :create
  
end
