require 'rails_helper'
require 'spec_helper'

RSpec.describe UserMailer, type: :mailer do
describe 'instructions' do
    #let(:user) { mock_model User, name: 'Umang', email: 'ur2136@columbia.edu', confirm_token: 'dsfaecgf' }

    before(:each) do
      @user = User.create({name: "Umang Raj", username: "Umang_Raj", email: "ur2136@columbia.edu", password: "test", email_confirmed: 0, confirm_token: 'dsfaecgf'})
    end

    let(:mail) { described_class.registration_confirmation(@user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Registration Confirmation')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([@user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['columbiachat@gmail.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(@user.name)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded)
        .to match("http://localhost:3000/users/#{@user.confirm_token}/confirm_email")
    end
end
end