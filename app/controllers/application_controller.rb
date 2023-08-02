class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    include Pundit::Authorization
    protect_from_forgery
      
    def not_found_method
        render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
    end
    def pundit_user
          
        current_user
    end
      

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_type])
    end
end
