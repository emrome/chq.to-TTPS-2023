class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    layout :set_layout

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name])
        devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    end

    private

    def set_layout
        if devise_controller? && controller_name == "sessions" && action_name == "new"
            "login"
        else
            "application"
        end
    end
end
