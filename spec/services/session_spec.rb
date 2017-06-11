require 'rails_helper'

RSpec.describe Session, type: :model do
  subject { described_class.new email: 'one@digits.com', password: 'password' }

  describe '#user' do
    before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(:user) }

    its(:user) { should eq :user }
  end

  describe '#valid?' do
    context do
      before { allow(User).to receive(:find_by).with(email: 'one@digits.com').and_return(nil) }

      it { should_not be_valid }
    end

    context do
      let(:user) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:authenticate).with('password').and_return(false) }

      it { should_not be_valid }
    end

    context do
      let(:user) { double }

      let(:auth_token) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:authenticate).with('password').and_return(true) }

      before { expect(user).to receive(:auth_tokens).and_return(auth_token) }

      before { expect(auth_token).to receive(:build).and_return(auth_token) }

      before { expect(auth_token).to receive(:save).and_return(false) }

      it { should_not be_valid }
    end

    context do
      let(:user) { double }

      let(:auth_token) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:authenticate).with('password').and_return(true) }

      before { expect(user).to receive(:auth_tokens).and_return(auth_token) }

      before { expect(auth_token).to receive(:build).and_return(auth_token) }

      before { expect(auth_token).to receive(:save).and_return(true) }

      before { expect(auth_token).to receive(:value).and_return(:auth_token) }

      it { should be_valid }
    end
  end

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { subject.save }

      its(:persisted?) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { subject.save }

      its(:persisted?) { should eq true }
    end
  end

  describe '#destroy' do
    it { expect { subject.destroy }.to_not raise_error }
  end

  describe '#user_blocked?' do
    context do
      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(nil) }

      its(:user_blocked?) { should eq false }
    end

    context do
      let(:user) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:blocked?).and_return(false) }

      its(:user_blocked?) { should eq false }
    end

    context do
      let(:user) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:blocked?).and_return(true) }

      its(:user_blocked?) { should eq true }
    end
  end
end
