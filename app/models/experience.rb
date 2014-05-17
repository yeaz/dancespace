class Experience < ActiveRecord::Base
 belongs_to :user
 has_many :experiencelinks
 accepts_nested_attributes_for :experiencelinks

 validates_length_of :content, maximum: 2000, message: "Your content should be 2000 characters or less"
end
