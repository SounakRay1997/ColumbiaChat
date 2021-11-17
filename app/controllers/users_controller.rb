class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      @current_user = current_user
      @rooms = Room.public_rooms
      @users = User.all_except(@current_user)
      @user_names = User.all_except(@current_user).pluck(:username)
      @room = Room.new
      @message = Message.new
      @room_name = get_name(@user, @current_user)
      @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
      @messages = @single_room.messages
      @departments = Course.distinct.pluck(:department_code)
      @private_rooms = Room.joins("INNER JOIN participants ON rooms.id = participants.room_id AND participants.user_id = #{current_user.id}").uniq unless not current_user
      if not params["dept_id"].nil?
        @rooms = @rooms.dept_rooms(params["dept_id"])
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