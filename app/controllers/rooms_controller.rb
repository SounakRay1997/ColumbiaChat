class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user

    public_rooms = Room.public_rooms
    user_lat = current_user.lat
    user_long = current_user.long
    tmp_rooms = []
    public_rooms.each  do |room| 
      room_dist_req = room.distance
      lat1 = room.lat
      lon1 = room.long
      if (isInRadius(user_lat, user_long, lat1, lon1, room_dist_req) && room.distance != Float::MAX) || (params["dept_id"].nil? && room.dept_code != "NONE") || (!params["dept_id"].nil? && params["dept_id"] != "ALL" && room.dept_code == params["dept_id"])
        tmp_rooms.append(room) 
      end 
      if params["dept_id"] == "ALL" && room.dept_code != "NONE"
        tmp_rooms.append(room)
      end 

    end
    @rooms = tmp_rooms


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
    @current_user = current_user;
    redirect_to '/signin' unless @current_user

    room_lat = current_user.lat
    room_long = current_user.long

    
    if params["room"]["private_room"] == "No"
      @room = Room.create(distance: params["room"]["distance"], name: params["room"]["name"], is_private: false, lat: room_lat, long: room_long)
    else
      @room = Room.create(distance: params["room"]["distance"], name: params["room"]["name"], is_private: true, lat: room_lat, long: room_long)
      sel_users = params["room"][:selected_users]
      if sel_users
        sel_users.each do |s_user|
            user = User.where(name: s_user)
            Participant.create(user_id: user.first.id, room_id: @room.id)
        end
        Participant.create(user_id: current_user.id, room_id: @room.id) #Add Current User
      end
    end 
    
    index()
    render "index"
  end

  @miles_conv = 5280.0
  
  def isInRadius(lat1, lon1, user_lat, user_long, roomDist) 
    dis_miles = Geocoder::Calculations.distance_between([lat1,lon1], [user_lat,user_long])
    dis_feet = dis_miles * 5280.0
    dis_feet <= roomDist 
    
  end

  def show
    
    index()
    @single_room = Room.find(params[:id]);
    @message = Message.new;
    @messages = @single_room.messages;

    render "index"
  end 
  
end
