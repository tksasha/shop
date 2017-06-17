require 'rails_helper'

RSpec.describe Block, type: :model do  
  describe '#save' do
    let(:user) { double }

    subject { described_class.new user }

    before do
      expect(user).to receive(:auth_tokens) do
        double.tap { |a| expect(a).to receive(:destroy_all) }
      end
    end

    before { expect(DateTime).to receive(:now).and_return(:timestamp) }

    before { expect(user).to receive(:update).with(blocked_at: :timestamp).and_return(:save) }

    its(:save) { should eq(:save) }
  end

  describe '#destroy' do
    let(:user) { double }

    subject { described_class.new user }

    before { expect(user).to receive(:update).with(blocked_at: nil).and_return(:destroy) }

    its(:destroy) { should eq(:destroy) }
  end

  describe '#user' do
    let(:user) { double }

    subject { described_class.new user }

    its(:user) { should eq(user) }
  end
end
