class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # in case of guest
    
    # Spectator
    can :read, :all
    
    # Choreographer
    
    # Studio Owner

  end
  
end
