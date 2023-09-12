class SessionsController < ApplicationController
    before_action :require_logged_out, only: %i(create new)
    before_action :require_logged_in, only: %i(destroy)
    
    def new
        @user = User.new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )
        
        if user.nil?
            flash.now[:errors] = ["Incorrect username and/or password"]
            render :new
        else
            login!(user)
            redirect_to user_url(user)
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end