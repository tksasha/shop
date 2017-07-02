require 'rails_helper'

RSpec.describe Confirmation, type: :model do
  describe '#confirm' do
    subject { stub_model User }

    let(:confirmation) { described_class.new subject }

    before { allow(subject).to receive(:confirmation_token).and_return(:token) }

    before { confirmation.confirm }

    its(:confirmed?) { should eq true }
  end

  describe '#to_param' do
    let(:user) { stub_model User }

    subject { described_class.new user }

    before { expect(user).to receive(:confirmation_token).and_return(:token) }

    its(:to_param) { should eq :token }
  end

  describe '.find' do
    before { expect(User).to receive(:find_by).with(confirmation_token: :token).and_return(:user) }

    subject { Confirmation.find :token }

    its(:user) { should eq :user }
  end
end
