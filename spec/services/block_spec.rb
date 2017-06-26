require 'rails_helper'

RSpec.describe Block, type: :model do  
  subject { described_class.new :user_id }

  describe '#save' do
    let(:user) { double }

    before { expect(User).to receive(:find).with(:user_id).and_return(user) }

    before do
      expect(user).to receive(:auth_tokens) do
        double.tap { |a| expect(a).to receive(:destroy_all) }
      end
    end

    before { expect(user).to receive(:touch).with(:blocked_at).and_return(:save) }

    its(:save) { should eq(:save) }
  end

  describe '#destroy' do
    let(:user) { double }

    before { expect(User).to receive(:find).with(:user_id).and_return(user) }

    before { expect(user).to receive(:update).with(blocked_at: nil).and_return(:destroy) }

    its(:destroy) { should eq(:destroy) }
  end

  describe '#user' do
    before { expect(User).to receive(:find).with(:user_id).and_return(:user) }

    its(:user) { should eq(:user) }
  end
end
