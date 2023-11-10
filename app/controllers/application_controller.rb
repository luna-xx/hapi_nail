class ApplicationController < ActionController::Base


before_action :configure_permitted_parameters, if: :devise_controller?

protected

def configure_permitted_parameters
  added_attrs = [ :nick_name, :name, :furigana_name, :email, :encrypted_password, :sex]
  devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
end

end
