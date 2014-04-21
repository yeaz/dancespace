class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  validates :username, :email, :password, :password_confirmation, :first_name, :last_name, :presence => true
  validates :username, :email, :uniqueness => true
  validates :password, :confirmation => true
  validates_length_of :password, :within => Devise.password_length
  
end
