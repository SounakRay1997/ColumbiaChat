require 'rails_helper'

RSpec.describe Room, type: :model do
  let (:user) { User.create({name: "Umang Raj", username: "Umang_Raj", email: "ur2136@columbia.edu", password: "test", email_confirmed: 0, confirm_token: 'dsfaecgf'})}
  let (:create_private) { Room.create(name:'random_name', is_private: true) }
  describe 'Associations' do
    it { should have_many(:messages) }
    it { should have_many(:participants) }
  end
  describe 'valid' do
    subject { described_class.new(name: 'general') }
    it { should validate_uniqueness_of(:name) }
  end
  describe 'private room' do
    it 'create private room' do
      subject { described_class.create_private_room( :user,'private_room' ) }
      expect(subject.is_private).to be_truthy
    end
  end
end