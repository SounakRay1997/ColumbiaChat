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
  
      render "rooms/index"
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
        flash[:message] = "Sorry. User does not exist"
        redirect_to '/signin'
      end
    end
  
    private
    def get_name(user1, user2)
      users = [user1, user2].sort
      "private_#{users[0].id}_#{users[1].id}"
    end

    

  end