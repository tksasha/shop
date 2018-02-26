require 'rails_helper'

RSpec.describe Confirmation, type: :model do
  subject { described_class.new token: 'XXX-YYY-ZZZ' }

  its(:token) { should eq 'XXX-YYY-ZZZ' }

  it { should validate_presence_of :token }

  describe '#valid?' do
    it { expect(subject).to receive(:user_must_exist) }

    after { subject.valid? }
  end

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(subject).to_not receive(:user) }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive_message_chain(:user, :update).with(confirmed: true).and_return(:result) }

      its(:save) { should eq :result }
    end
  end

  describe '#user' do
    context do
      before { subject.instance_variable_set :@user, :user }

      its(:user) { should eq :user }
    end

    context do
      subject { described_class.new }

      before { expect(User).to_not receive(:find_by) }

      its(:user) { should be_nil }
    end

    context do
      before { expect(User).to receive(:find_by).with(confirmation_token: 'XXX-YYY-ZZZ').and_return(:user) }

      its(:user) { should eq :user }
    end
  end

  describe '#user_must_exist' do
    let(:call) { -> { subject.send :user_must_exist } }

    context do
      subject { described_class.new }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      before { expect(subject).to receive(:user).and_return(:user) }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      before { expect(subject).to receive(:user).and_return(nil) }

      it { expect(&call).to change { subject.errors.details }.to token: [{ error: :invalid }] }
    end
  end
end
