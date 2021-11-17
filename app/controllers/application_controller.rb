class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
      if session[:user_id]
        @current_user  = User.find(session[:user_id])
      end
    end
    
    def log_in(user, entered_password)
      password = user.password
      @entered_password = entered_password
      if user.id and password.eql?(@entered_password)
        session[:user_id] = user.id
        @current_user = user
        redirect_to root_path
      else
        flash[:message]="Incorrect Password"
        redirect_to '/signin'
      end
    end
    
    def logged_in?
      !current_user.nil?
    end
    
    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
end
