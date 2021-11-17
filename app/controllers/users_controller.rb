class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      @current_user = current_user
      @rooms = Room.public_rooms
      @users = User.all_except(@current_user)
      @room = Room.new
      @message = Message.new
      @room_name = get_name(@user, @current_user)
      @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
      @messages = @single_room.messages
      @departments = Course.distinct.pluck(:department_code)
      if params["dept_id"].nil?
        @select_departments = Course.all.pluck(:course_title, :course_subtitle).uniq!
      else
        @select_departments = Course.where(department_code: params["dept_id"]).pluck(:course_title, :course_subtitle).uniq!
      end
      if @select_departments
        @select_departments.each do |n|
          if n[1].nil?
            n[1] = ""
          end 
        end 
      end 
      render "rooms/index"
    end

    def create
      #byebug
      @user = User.new(user_params)
      @user.save
      redirect_to '/signin'
    end

    def user_params
      params.require(:user).permit(:email, :password, :username)
    end
  
    private
    def get_name(user1, user2)
      users = [user1, user2].sort
      "private_#{users[0].id}_#{users[1].id}"
    end

    

  end