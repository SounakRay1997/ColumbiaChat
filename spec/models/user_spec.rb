require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  before { @user = User.new(name: "Umang Raj", username: "Umang_Raj", email: "ur2136@gmail.com") }
  describe 'valid username' do
    subject { @user }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
  end
  describe "when email is not lionmail account" do
    before { @user }
    it { should_not be_valid }
  end
  describe "when email is lionmail account" do
    before { @user.email = "ur2136@columbia.edu" }
    it { should_not be_valid }
  end
end