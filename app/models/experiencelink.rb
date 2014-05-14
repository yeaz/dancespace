class Experiencelink < ActiveRecord::Base
  belongs_to :experience
  belongs_to :collab, polymorphic: true
end
