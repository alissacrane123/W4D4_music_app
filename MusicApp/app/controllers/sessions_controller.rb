class SessionsController < ApplicationController
    def new
        render :new 
    end 

    def create 
        user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if user.nil?
            render json: 'The email/password combination you entered is incorrect'
        else  
            log_in_user!(user)
            redirect_to user_url(user)
        end 
    end 

    def destroy 
        if current_user.nil?
            redirect_to new_session_url 
        else 
            current_user.reset_session_token!
            session[:session_token] = nil 
            redirect_to new_session_url
        end 
    end 
end
