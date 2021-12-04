class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    if @current_user
      public_rooms = Room.public_rooms
      user_lat = current_user.lat
      user_long = current_user.long
      tmp_rooms = []
      public_rooms.each  do |room| 
        room_dist_req = room.distance
        lat1 = room.lat
        lon1 = room.long
        # puts("HERE XYZ")
        # puts(room.name)
        if isInRadius(user_lat, user_long, lat1, lon1, room_dist_req) || (params["dept_id"].nil? && room.dept_code != "NONE") || ( !params["dept_id"].nil? && params["dept_id"] != "ALL" && room.dept_code == params["dept_id"])
          tmp_rooms.append(room) 
        end 
        if params["dept_id"] == "ALL" && room.dept_code != "NONE"
          tmp_rooms.append(room)
        end 

      end
      @rooms = tmp_rooms
    else 
      @rooms = Room.all
    end

    # if @rooms and not params["dept_id"].nil?
    #   @rooms = @rooms.dept_rooms(params["dept_id"])
    # end
    @users = User.all_except(@current_user);
    @room = Room.new
    @user_names = User.all_except(@current_user).pluck(:name)
    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code).prepend("ALL")
    
    @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user
  end

  def create
    @current_user = current_user; redirect_to '/signin' unless @current_user
    if current_user && current_user.lat && current_user.long 
      room_lat = current_user.lat
      room_long = current_user.long
    else 
      room_lat = 0;room_long = 0
    end
    
    if params["room"]["private_room"] == "No"
      @room = Room.create(distance: params["room"]["distance"], name: params["room"]["name"], is_private: false, lat: room_lat, long: room_long)
    else
      @room = Room.create(distance: params["room"]["distance"], name: params["room"]["name"], is_private: true, lat: room_lat, long: room_long)
      sel_users = params["room"][:selected_users]
      # puts sel_users
      if sel_users
        sel_users.each do |s_user|
            user = User.where(name: s_user)
            puts "potato"
            Participant.create(user_id: user.first.id, room_id: @room.id)
        end
        Participant.create(user_id: current_user.id, room_id: @room.id) #Add Current User
      end
    end 
    
    @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user

    @users = User.all_except(@current_user)
    @user_names = User.all_except(@current_user).pluck(:name)
    @rooms = Room.public_rooms
    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code).prepend("ALL")
    @rooms = Room.public_rooms
    if not params["dept_id"].nil?
      @rooms = @rooms.dept_rooms(params["dept_id"])
    end
    render "index"
    
  end

  @miles_conv = 5280.0
  
  def isInRadius(lat1, lon1, user_lat, user_long, roomDist) 
    dis_miles = Geocoder::Calculations.distance_between([lat1,lon1], [user_lat,user_long])
    dis_feet = dis_miles * 5280.0
    # puts("FEET AWAY", dis_feet, " ALLOWED ", roomDist, " SHOWN: ",  dis_feet <= roomDist   )
    dis_feet <= roomDist 
    
  end

  def show
    @current_user = current_user;
    @single_room = Room.find(params[:id]);
    public_rooms = Room.public_rooms;
    @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user;
    user_lat = current_user.lat;
    user_long = current_user.long;
    tmp_rooms = [];
    public_rooms.each do |room|
      room_dist_req = room.distance;
      lat1 = room.lat;
      lon1 = room.long;
      if isInRadius(user_lat, user_long, lat1, lon1, room_dist_req) || (params["dept_id"].nil? && room.dept_code != "NONE") || ( !params["dept_id"].nil? && params["dept_id"] != "ALL" && room.dept_code == params["dept_id"])
        tmp_rooms.append(room) 
      end 
      if params["dept_id"] == "ALL" && room.dept_code != "NONE"
        tmp_rooms.append(room)
      end  
    end 
    @rooms = tmp_rooms;
    @users = User.all_except(@current_user);
    @user_names = User.all_except(@current_user).pluck(:name);
    @room = Room.new;
    @message = Message.new;
    @messages = @single_room.messages;

    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code).prepend("ALL")
    if not params["dept_id"].nil?
      @rooms = @rooms.dept_rooms(params["dept_id"])
    end
    render "index"
  end 
  
end
