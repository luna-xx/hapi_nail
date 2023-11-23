class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_in_path_for(resource)
  user_my_page_path
end

def after_sign_out_path_for(resource_or_scope)
    root_path
end

protected

def configure_permitted_parameters
  added_attrs = [ :nick_name, :name, :furigana_name, :sex]
  devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
end

end
