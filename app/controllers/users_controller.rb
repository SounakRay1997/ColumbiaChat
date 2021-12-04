class UsersController < ApplicationController

    def show
      @user = User.find(params[:id])
      @current_user = current_user
      user_lat = current_user.lat
      user_long = current_user.long
      public_rooms = Room.public_rooms
      tmp_rooms = []
      public_rooms.each  do |room|
        room_dist_req = room.distance
        lat1 = room.lat
        lon1 = room.long
        if isInRadius(user_lat, user_long, lat1, lon1, room_dist_req) || (params["dept_id"].nil? && room.dept_code != "NONE") || ( !params["dept_id"].nil? && params["dept_id"] != "ALL" && room.dept_code == params["dept_id"])
          tmp_rooms.append(room) 
        end 
        if params["dept_id"] == "ALL" && room.dept_code != "NONE"
          tmp_rooms.append(room)
        end 
      end
      @rooms = tmp_rooms
      @users = User.all_except(@current_user)
      @user_names = User.all_except(@current_user).pluck(:name)
      @room = Room.new
      @message = Message.new
      @room_name = get_name(@user, @current_user)
      @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
      @messages = @single_room.messages
      @departments = Course.distinct.pluck(:department_code).prepend("ALL")
      @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user
      if not params["dept_id"].nil?
        @rooms = @rooms.dept_rooms(params["dept_id"])
      end
      render "rooms/index"
    end

    def isInRadius(lat1, lon1, user_lat, user_long, roomDist) 
      dis_miles = Geocoder::Calculations.distance_between([lat1,lon1], [user_lat,user_long])
      dis_feet = dis_miles * 5280.0
      #puts("FEET AWAY", dis_feet, " ALLOWED ", roomDist, " SHOWN: ",  dis_feet <= roomDist   )
      dis_feet <= roomDist 
      
    end

    def create
      #byebug
      @user = User.new(user_params)
      if @user.validate
        @user.save
        UserMailer.registration_confirmation(@user).deliver
        flash[:success] = "Please confirm your email address to continue"
        redirect_to '/signin'
      elsif @user.errors.first[0].eql?(:username) && @user.errors.first[1].eql?("has already been taken")
        flash[:message]="This username already exists. Please choose a different username."
        redirect_to '/signup'
      elsif @user.errors.first[0].eql?(:email) and @user.errors.first[1].eql?("has already been taken")
        flash[:message]="You already have an account. Please sign in with your existing account."
        redirect_to '/signup'
      elsif @user.errors.first[0].eql?(:email) and @user.errors.first[1].eql?("is invalid")
        flash[:message]="Please use your LionMail Account to Sign Up."
        redirect_to '/signup'
      else
        flash[:message]="Password and Confirm Password must match."
        redirect_to '/signup'
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :username, :password_confirmation, :name)
    end

    def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "Welcome to the ColumbiaChat! Your email has been confirmed.
      Please sign in to continue."
        redirect_to '/signin'
      else
        flash[:message] = "This user has already been verified. Please use your username/password to login."
        redirect_to '/signin'
      end
    end
  
    private
    def get_name(user1, user2)
      users = [user1, user2].sort
      "private_#{users[0].id}_#{users[1].id}"
    end

  end
