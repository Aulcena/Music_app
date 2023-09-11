class SessionsController < ApplicationController
    
    def new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )
        
        if user.nil?
            flash.now[:errors] = ["Incorrect username and/or password"]
        else
            login!(user)
            redirect_to user_url(user)
        end
    end

    def destroy
        logout!
    end
end