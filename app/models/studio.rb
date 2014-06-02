class Studio < ActiveRecord::Base

  # *** ASSOCIATIONS *** #
  has_many :members, class_name: 'User', through: :studio_membership
  has_many :memberships, dependent: :destroy

  # Relationship between Studio and Experiencelink
  # :collab means that the model can be a collaborator for an
  # experiencelink
  has_many :experiencelinks, as: :collab
  
  has_many :events, dependent: :destroy
  
  # *** VALIDATIONS *** #
  validates :name, presence: { message: 'Please provide a name' }
  validates :address_line1, :city, :state, :zip_code, :presence => true
  validates :description, presence: { message: 'Please provide a description' }
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/,
                              message: 'Please provide a valid email address' }
 validate :check_phone_number
 

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

  def get_address
    return address_line1 + ' ' + address_line2 + ', ' + city + ' ' + state + ' ' + zip_code
  end

  def get_phone_number
    if phone_area_code != "" and phone_1 != "" and phone_2 != ""
      return "(" + phone_area_code + ") " + phone_1 + "-" + phone_2
    else
      return ""
    end
  end
  
end
