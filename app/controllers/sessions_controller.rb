class SessionsController < ApplicationController

    def create
      user = User.find_by(username: params[:session][:username])
      password = params[:session][:password]
      if user
        log_in(user, password)
      else
        flash[:message]="Incorrect Username or Password"
        redirect_to '/signin'
      end
    end
  
    def destroy
      log_out if logged_in?
      redirect_to root_path
    end

    

    def signup
      @user = User.new
      render 'signup'
    end
  
end