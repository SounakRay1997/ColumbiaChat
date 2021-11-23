class SessionsController < ApplicationController

    def create
      user = User.find_by(username: params[:session][:username])
      password = params[:session][:password]
      if user
        if cookies[:lat_lng]
          lat_lng = cookies[:lat_lng].split("|")
          lat_gps = lat_lng[0]
          long_gps = lat_lng[1]
        else 
          lat_gps = 0
          long_gps = 0
        end
        if user
          user.update(lat: lat_gps, long: long_gps)
          
        end
        if user.email_confirmed
          log_in(user, password)
        else
          flash[:message]="Please activate your account by following the instructions in the confirmation email you received. If you did not receive the mail please check your spam folder."
          redirect_to '/signin'
        end
      else
        flash[:message]="Incorrect Username"
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