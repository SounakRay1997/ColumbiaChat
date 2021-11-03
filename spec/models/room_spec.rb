require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'Associations' do
    it { should have_many(:messages) }
    it { should have_many(:participants) }
  end
  describe 'valid' do
    subject { described_class.new(name: 'general') }
    it { should validate_uniqueness_of(:name) }
  end
end