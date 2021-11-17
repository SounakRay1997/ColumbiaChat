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
        dis_miles = Geocoder::Calculations.distance_between([lat1,lon1], [user_lat,user_long])
        dis_feet = dis_miles * 5280
        if dis_feet <= room_dist_req
          tmp_rooms.append(room)
        end
      end
      @rooms = tmp_rooms
    else 
      @rooms = Room.all
    end
    @users = User.all_except(@current_user)
    @room = Room.new
  end

  def create
    @current_user = current_user
    room_lat = current_user.lat
    room_long = current_user.long
    @room = Room.create(name: params["room"]["name"], is_private: false, lat: room_lat, long: room_long, distance: 500)
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages
  
    render "index"
  end
end
