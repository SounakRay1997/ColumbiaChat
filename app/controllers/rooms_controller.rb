class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    @rooms = Room.public_rooms
    if not params["dept_id"].nil?
      @rooms = @rooms.dept_rooms(params["dept_id"])
    end

    @users = User.all_except(@current_user)
    @user_names = User.all_except(@current_user).pluck(:username)

    @room = Room.new

    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code)
    
    @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user
  end

  def create
    if params["room"]["private_room"] == "No"
      @room = Room.create(name: params["room"]["name"], is_private: false)
    else
      @room = Room.create(name: params["room"]["name"], is_private: true)
      sel_users = params["room"][:selected_users]
      puts sel_users
      if sel_users
        sel_users.each do |s_user|
            user = User.where(username: s_user)
            Participant.create(user_id: user.first.id, room_id: @room.id)
        end
        Participant.create(user_id: current_user.id, room_id: @room.id) #Add Current User
      end
      @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user
     
    end

    @current_user = current_user
    @users = User.all_except(@current_user)
    @user_names = User.all_except(@current_user).pluck(:username)
    @rooms = Room.public_rooms
    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code)
    @rooms = Room.public_rooms
    if not params["dept_id"].nil?
      @rooms = @rooms.dept_rooms(params["dept_id"])
    end
    render "index"
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user
    @users = User.all_except(@current_user)
    @user_names = User.all_except(@current_user).pluck(:username)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages

    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code)
    if not params["dept_id"].nil?
      @rooms = @rooms.dept_rooms(params["dept_id"])
    end
    render "index"
  end
  
end
