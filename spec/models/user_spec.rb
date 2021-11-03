require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid' do
    subject { described_class.new(username: 'jack12') }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:username) }
  end
end