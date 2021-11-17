class SessionsController < ApplicationController

    def create
      user = User.find_by(username: params[:session][:username])
      lat_lng = cookies[:lat_lng].split("|")
      lat_gps = lat_lng[0]
      long_gps = lat_lng[1]
      user.update(lat: lat_gps, long: long_gps)
      
      if user
        log_in(user)
      else
        render 'new'
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