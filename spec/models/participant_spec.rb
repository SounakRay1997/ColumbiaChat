require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end
end