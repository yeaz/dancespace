class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:email, :password, :password_confirmation, :first_name, :last_name)
  end

  
end
