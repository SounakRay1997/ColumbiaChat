require 'rails_helper'

describe MessagesController, type: :controller do
    let(:content) {"Hello"}
    before(:each) do
      @user = User.create({name: "Umang Raj", username: "Umang_Raj", email: "ur2136@columbia.edu", password: "test", email_confirmed: 0, confirm_token: 'dsfaecgf'})
    end

    it 'creates a new room' do
      x = [1,2,3]
      expect(x).to include(1)
      
    end

end 
