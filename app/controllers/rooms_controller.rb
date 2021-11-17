class RoomsController < ApplicationController
  def index
    @current_user = current_user
    redirect_to '/signin' unless @current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @user_names = User.all_except(@current_user).pluck(:username)

    @room = Room.new

    @courses = Course.all 
    @departments = Course.distinct.pluck(:department_code)
    if params["dept_id"].nil?
      @select_departments = Course.all.pluck(:course_title, :course_subtitle).uniq!
    else
      @select_departments = Course.where(department_code: params["dept_id"]).pluck(:course_title, :course_subtitle).uniq!
    end
    @select_departments.each do |n|
      if n[1].nil?
        n[1] = ""
      end 
    end 

  end

  def create
    if params["room"]["private_room"] == "No"
      @room = Room.create(name: params["room"]["name"], is_private: false)
    else
      @room = Room.create(name: params["room"]["name"], is_private: true)
      sel_users = params["room"][:selected_users]
      puts sel_users
      sel_users.each do |s_user|
          user = User.where(username: s_user)
          Participant.create(user_id: user.first.id, room_id: @room.id)
      end
    end
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
