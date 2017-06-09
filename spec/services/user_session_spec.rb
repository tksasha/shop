require 'rails_helper'

RSpec.describe UserSession, type: :model do
  subject { described_class.new email: 'one@digits.com', password: 'password' }

  it { should delegate_method(:user_id).to(:user).as(:id) }

  describe '#user' do
    before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(:user) }

    its(:user) { should eq :user }
  end

  describe '#valid?' do
    context do
      before { allow(User).to receive(:find_by).with(email: 'one@digits.com').and_return(nil) }

      before { subject.valid? }

      it { should_not be_valid }

      it { expect(subject.errors[:email]).to eq [I18n.t('user_session.error.validation')] }
    end

    context do
      let(:user) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:authenticate).with('password').and_return(false) }

      before { subject.valid? }

      it { expect(subject.errors[:password]).to eq [I18n.t('user_session.error.validation')] }
    end

    context do
      let(:user) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:authenticate).with('password').and_return(true) }

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

      before { expect(user).to receive(:blocked).and_return(false) }

      its(:user_blocked?) { should eq false }
    end

    context do
      let(:user) { double }

      before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(user) }

      before { expect(user).to receive(:blocked).and_return(true) }

      its(:user_blocked?) { should eq true }
    end
  end
end
