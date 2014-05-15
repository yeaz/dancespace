class Experience < ActiveRecord::Base
 belongs_to :user
 has_many :experiencelinks
 accepts_nested_attributes_for :experiencelinks
end
