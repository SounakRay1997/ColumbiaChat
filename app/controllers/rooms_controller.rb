class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new

    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code)
  end

  def create
    @room = Room.create(name: params["room"]["name"], is_private: false)
  end

  def show
    @current_user = current_user
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages

    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code)
    render "index"
  end
end
