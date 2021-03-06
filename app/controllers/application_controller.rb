class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    helper_method :is_charity?

    helper_method :is_donor?

    protected

      def is_charity?
        !current_user.nil? && current_user.role == 'charity'
      end

      def is_donor?
        !current_user.role == 'donor'
      end

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :first_name, :last_name, :description, :location, :facebook_profile, :twitter_profile, :profile_picture, :role])     
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :first_name, :last_name, :description, :location, :facebook_profile, :twitter_profile, :profile_picture])
      end

      def after_sign_in_path_for(resource)
        users_path
      end
  end
