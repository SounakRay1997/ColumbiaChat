require 'rails_helper'

describe SessionsController, type: :controller do
    let(:user_params) { { username: 'Umang_Raj', password: 'test' } }
    let(:params) { {session: user_params} }
    subject { post signin_path, params: params}
    render_views

    before(:each) do 
        @user = User.create({username: "Umang_Raj", email: "umang@columbia.edu", password: "test", email_confirmed: 1})
    end

    it 'logs in existing user' do
        @request.cookies[:lat_lng] = "0|0"
        post(:create, params: params)
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        # cookies[:lat_lng] = "0|0"
        puts cookies[:lat_lng]
        expect(cookies[:lat_lng]).to eq "0|0"
    end

    it 'logs in existing user whose email is not confirmed' do
        post(:create, params: params)
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
    end

    it 'logs in non-existing user' do 
        post(:create, params: {session: {username: "banana", password: "lol", email_confirmed: 1}})
        expect(response).to redirect_to('/signin')
    end
    
    it 'log out existing user' do 
        post(:create, params: params)
        delete(:destroy, params: params)
        expect(session[:username]).to eq nil 
        expect(session[:user_id]).to eq nil 
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
    end 

    it 'log out non-existing user' do 
        delete(:destroy, params: {session: {username: "banana"}})
        expect(session[:username]).to eq nil 
        expect(session[:user_id]).to eq nil
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
    end 

    it 'go to signup' do
        post(:signup)
        expect(response).to render_template('signup')
    end 

end

describe SessionsController, type: :controller do
    let(:user_params) { { username: 'Umang_Raj', password: 'test' } }
    let(:params) { {session: user_params} }
    subject { post signin_path, params: params}
    render_views

    before(:each) do
        @user = User.create({username: "Umang_Raj", email: "umang@columbia.edu", password: "test", email_confirmed: 0})
    end

    it 'does not log in an existing user' do
        post(:create, params: params)
        expect(response).to redirect_to('/signin')
    end

end

describe SessionsController, type: :controller do
    let(:user_params) { { username: 'Umang_Raj', password: 'test123' } }
    let(:params) { {session: user_params} }
    subject { post signin_path, params: params}
    render_views

    before(:each) do
        @user = User.create({username: "Umang_Raj", email: "umang@columbia.edu", password: "test", email_confirmed: 0})
    end

    it 'does not log in an existing user with wrong password' do
        post(:create, params: params)
        expect(response).to redirect_to('/signin')
    end

end

