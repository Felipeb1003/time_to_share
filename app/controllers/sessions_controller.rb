class SessionsController < ApplicationController

    def welcome
    end

    def new 
    end

    def create
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id

            redirect_to user_path(user)
        else
            flash[:message] = "Email or Password incorrect. Please try again."
            redirect_to '/log_in'
        end

    end

    def destroy
        session.delete(:user_id)
        redirect_to '/log_in'
    end

    def omniauth
        user = User.create_from_omniauth(auth)
        if user.valid?
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            flash[:message] = user.errors.full_messages.join(" - ")
            redirect_to '/log_in'
        end
    end

    private
    def auth
        request.env['omniauth.auth']
    end

    
end
