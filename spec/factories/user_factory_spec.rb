require 'rails_helper'

RSpec.describe UserFactory do
  subject { described_class.new email: 'one@digits.com', password: 'password' }

  describe '#build' do
    before { expect(User).to receive(:new).with(email: 'one@digits.com', password: 'password', role: :user).and_return(:resource) }

    its(:build) { should eq :resource }
  end

  describe '.build' do
    before do
      #
      # described_class.new(:params).build
      #
      expect(described_class).to receive(:new).with(:params) do
        double.tap { |a| expect(a).to receive(:build) }
      end
    end

    subject { described_class.build :params }

    it { expect { subject }.to_not raise_error }
  end
end
