require 'rails_helper'

RSpec.describe Session, type: :model do
  subject { described_class.new email: 'one@digits.com', password: :password }

  it { should validate_presence_of :email }

  it { should validate_presence_of :password }

  it { expect(subject.method(:save).original_name).to eq(:valid?) }

  its(:persisted?) { should eq false }

  describe '#auth_token' do
    context do
      before { subject.instance_variable_set :@auth_token, :auth_token }

      its(:auth_token) { should eq :auth_token }
    end

    context do
      before { expect(subject).to receive(:user).and_return(nil) }

      its(:auth_token) { should be_nil }
    end

    context do
      before { expect(subject).to receive_message_chain(:user, :auth_tokens, :create!).and_return(:auth_token) }

      its(:auth_token) { should eq :auth_token }
    end
  end

  describe '#user' do
    context do
      before { subject.instance_variable_set :@user, :user }

      its(:user) { should eq :user }
    end

    context do
      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(:user) }

      its(:user) { should eq :user }
    end

    context do
      subject { described_class.new }

      its(:user) { should be_nil }
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

      it { expect(&call).to change { subject.errors.details }.to email: [{ error: :invalid }] }
    end
  end

  describe '#password_must_pass_authentication' do
    let(:call) { -> { subject.send :password_must_pass_authentication } }

    context do
      subject { described_class.new }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      before { expect(subject).to receive(:user).and_return(nil) }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      let(:user) { stub_model User }

      before { expect(subject).to receive(:user).twice.and_return(user) }

      context do
        before { expect(user).to receive(:authenticate).with(:password).and_return(true) }

        it { expect(&call).to_not change { subject.errors.details } }
      end

      context do
        before { expect(user).to receive(:authenticate).with(:password).and_return(false) }

        it { expect(&call).to change { subject.errors.details }.to(password: [{ error: :invalid }]) }
      end
    end
  end

  describe '#user_must_not_be_blocked' do
    let(:call) { -> { subject.send :user_must_not_be_blocked } }

    before { allow(subject).to receive(:user).and_return user }

    context do
      let(:user) { nil }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      context do
        let(:user) { stub_model User, blocked_at: nil }

        it { expect(&call).to_not change { subject.errors.details } }
      end

      context do
        let(:user) { stub_model User, blocked_at: DateTime.now }

        it { expect(&call).to change { subject.errors.details }.to(email: [{ error: 'user is blocked' }]) }
      end
    end
  end

  describe '#user_must_be_confirmed' do
    let(:call) { -> { subject.send :user_must_be_confirmed } }

    before { allow(subject).to receive(:user).and_return user }

    context do
      let(:user) { nil }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      context do
        let(:user) { stub_model User, confirmed: true }

        it { expect(&call).to_not change { subject.errors.details } }
      end

      context do
        let(:user) { stub_model User, confirmed: false }

        it { expect(&call).to change { subject.errors.details }.to(email: [{ error: 'email is not confirmed' }]) }
      end
    end
  end
end
