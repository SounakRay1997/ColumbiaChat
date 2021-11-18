class RoomsController < ApplicationController
  def index
    @current_user = current_user; redirect_to '/signin' unless @current_user
    if @current_user
      public_rooms = Room.public_rooms;user_lat = current_user.lat;user_long = current_user.long;tmp_rooms = [];public_rooms.each  { |room| room_dist_req = room.distance;lat1 = room.lat;lon1 = room.long;tmp_rooms.append(room) if isInRadius(user_lat, user_long, lat1, lon1, room_dist_req) }
      @rooms = tmp_rooms
    else 
      @rooms = Room.all
    end
    @users = User.all_except(@current_user);@room = Room.new
  end

  def create
    @current_user = current_user; redirect_to '/signin' unless @current_user
    if current_user.lat && current_user.long 
      room_lat = current_user.lat;room_long = current_user.long
    else 
      room_lat = 0;room_long = 0
    end
    @room = Room.create(distance: params["room"]["distance"], name: params["room"]["name"], is_private: false, lat: room_lat, long: room_long)
  end

  @miles_conv = 5280
  
  def cal(lat1,lon1, user_lat,user_long) Geocoder::Calculations.distance_between([lat1,lon1], [user_lat,user_long]) end

  def isInRadius(lat1, lon1, user_lat, user_long, roomDist) dis_miles = cal(lat1,lon1, user_lat,user_long);dis_feet = dis_miles * @miles_conv;return roomDist >= dis_feet end

  def show
    @current_user = current_user;@single_room = Room.find(params[:id]);public_rooms = Room.public_rooms;user_lat = current_user.lat;user_long = current_user.long;tmp_rooms = []
    public_rooms.each  { |room| room_dist_req = room.distance;lat1 = room.lat;lon1 = room.long;tmp_rooms.append(room) if isInRadius(user_lat, user_long, lat1, lon1, room_dist_req) } ;@rooms = tmp_rooms;@users = User.all_except(@current_user);@room = Room.new;@message = Message.new;@messages = @single_room.messages;render "index"
  end
end
