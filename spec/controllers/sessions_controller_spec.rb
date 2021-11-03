require 'rails_helper'

describe SessionsController, type: :controller do
    let(:user_params) { { username: 'Umang_Raj' } }
    let(:params) { {session: user_params} }
    subject { post signin_path, params: params}
    render_views
    # let (:user) {User.create(username: user_params[:username])}
    # subject { get signin_path}
    
    # it 'creates user' do
    #     subject
    #     assert_select("input")
    #     # expect { subject }.to change { User.count }
    #     # User.last.tap { |user| expect(user.username).to eq user_params[:username] }
    #   end
    before(:each) do 
        @user = User.create({username: "Umang_Raj", email: "umang@columbia.edu", password: "test"})
    end

    it 'logs in existing user' do
        post(:create, params: params)
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        # visit signin_path
        # def self.sign_in_a_user(user)
        #     login_as("potato")
        # end
        # get signin_path
        # subject
        
        # expect (session[:current_user_id]).to eq user.id
        # post(:create, params[:session][:username]= "potato")
        # print page.body
        
        # assert_select("input")
        # fill_in "plswork" ,with: "potato"
        # click_button "Sign in"
        # get signin_path
        # post signin_path
        # print page.body
        # puts (User.find(session[:current_user_id]))
        # expect(page).to have_content 'Hi', count: 1
        # assert-select("h5")
        # expect(session[:current_user_id]).to eq User.last.id
      end

    it 'logs in new user' do 
        post(:create, params: {session: {username: "banana"}})
        expect(response).to render_template('new')
    end
    
    it 'log out user' do 
        post(:destroy, params: {session: {username: "potato"}})
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
    end 

    it 'go to signup' do
        post(:signup)
        expect(response).to render_template('signup')
    end 
    # describe 'POST message' do
        
    #     it 'should return succesfully' do 
    #         get :current_user
    #     end 
    # end 
end 
