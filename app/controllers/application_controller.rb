class ApplicationController < ActionController::Base

    helper_method :current_user
    
    private

    def current_user
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    def login!(user)
        session[:session_token] = user.reset_user_session_token!
    end

    def logout!
        current_user.try(:reset_user_session_token!)
        session[:session_token] = nil
    end

    def require_logged_out
        redirect_to new_session_url if current_user
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end
end
