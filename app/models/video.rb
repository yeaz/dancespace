class Video < ActiveRecord::Base

  # *** ASSOCIATION *** #
  belongs_to :user
  acts_as_taggable_on :tags
  
  # *** VALIDATIONS *** #
  validates :title, presence: { message: 'Please input a title.' }
  validates :description, presence: { message: 'Please input a description.' }
  validates :youtube_url, presence: { message: 'Please provide a Youtube URL' }, 
                          format: { with: /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/, multiline: true,
                                    message: 'The Youtube URL is not valid' }
  validates :youtube_id, presence: { message: 'There was an internal error when saving video' } 

  def owned_by?(user)
    self.user_id == user.id
  end
  
  def set_youtube_id
    if self.youtube_url.blank?
      self.youtube_id = 'no_youtube_id'
    else
      regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
      match = self.youtube_url.match(regExp)
      if match && match[2].length==11
        self.youtube_id = match[2]
      else
        self.youtube_id = 'no_youtube_id'
      end
    end 
  end
  
end
