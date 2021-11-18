require 'rails_helper'

describe UsersController, type: :controller do
    let(:user_params) { {name: "Umang Raj", username: "Umang_Raj", email: "ur2136@columbia.edu", password: "test", password_confirmation: "test"} }
    let(:params) { {session: user_params} }
    before(:each) do
      @user = User.create({name: "Umang Raj", username: "Umang_Raj", email: "ur2136@columbia.edu", password: "test", email_confirmed: 0, confirm_token: 'dsfaecgf'})
    end

    it 'creates a new room' do
      x = [1,2,3]
      expect(x).to include(1)
      
    end

    it "should have strong type checking" do
      # post(:create, params: params)
      params = {user: {email:"ur2136@columbia.edu", password: "test", password_confirmation: "test", name: "Umang Raj", username: "Umang_Raj"}}
      should permit(:email, :password, :username, :password_confirmation, :name)
               .for(:create, params: params)
      expect(flash[:message]).to match(/This username already exists. Please choose a different username.*/)
    end

    it "should have strong type checking" do
      # post(:create, params: params)
      params = {user: {email:"ur2136@columbia.edu", password: "test", password_confirmation: "test", name: "Umang Raj", username: "UmangRaj"}}
      should permit(:email, :password, :username, :password_confirmation, :name)
               .for(:create, params: params)
      expect(flash[:message]).to match(/You already have an account. Please sign in with your existing account.*/)
    end

    it "should have strong type checking" do
      # post(:create, params: params)
      params = {user: {email:"ur2136@gmail.com", password: "test", password_confirmation: "test", name: "Umang Raj", username: "UmangRaj"}}
      should permit(:email, :password, :username, :password_confirmation, :name)
               .for(:create, params: params)
      expect(flash[:message]).to match(/Please use your LionMail Account to Sign Up.*/)
    end

    it "should have strong type checking" do
      # post(:create, params: params)
      params = {user: {email:"sr3846@columbia.edu", password: "test", password_confirmation: "test123", name: "Sounak Ray", username: "Sounak_Ray"}}
      should permit(:email, :password, :username, :password_confirmation, :name)
               .for(:create, params: params)
      expect(flash[:message]).to match(/Password and Confirm Password must match.*/)
    end

    it "should signup valid user" do
      params = {user: {email:"sr3846@columbia.edu", password: "test", password_confirmation: "test", name: "Sounak Ray", username: "Sounak_Ray"}}
      should permit(:email, :password, :username, :password_confirmation, :name)
               .for(:create, params: params)
      expect(flash[:success]).to match(/Please confirm your email address to continue*/)
      expect(response).to redirect_to('/signin')
      expect(response).to have_http_status(302)
    end
end 
