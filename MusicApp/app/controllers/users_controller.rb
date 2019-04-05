class UsersController < ApplicationController
    def index 
        @users = User.all 
        render :index 
    end 

    def show 
        @user = User.find(params[:id])
        render :show 
    end 

    def create
        # why not do user_params?
        @user = User.new(user_params)
        
        if @user.save
            log_in_user!(@user)
            redirect_to user_url(@user)
        else 
            render json: @user.errors.full_messages
        end 
    end 
    
    def new
        @user = User.new
    end 

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end 
end
