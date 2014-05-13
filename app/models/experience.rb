class Experience < ActiveRecord::Base
  belongs_to :user
  has_many :experience_links
  accepts_nested_attributes_for :experience_links
end
