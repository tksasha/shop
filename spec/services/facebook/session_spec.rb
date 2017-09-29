require 'rails_helper'

RSpec.describe Facebook::Session, type: :model do
  subject { described_class.new access_token: 'access_token'  }

  describe '#facebook_user' do
    let(:response) { double read: '{ "id": 1, "email": "one@digits.com" }' }

    before do
      expect(subject).to receive(:open).
        with('https://graph.facebook.com/me?fields=id,email&access_token=access_token').
        and_return(response)
    end

    its(:facebook_user) { should eq({ 'id' => 1, 'email' => 'one@digits.com' }) }
  end

  describe '#user' do
    let(:new_record) { double }

    before { allow(subject).to receive(:facebook_user).and_return({ 'id' => 1, 'email' => 'one@digits.com' }) }

    before { expect(User).to receive(:find_or_create_by).with(facebook_id: 1).and_yield(new_record).and_return :user }

    before { expect(new_record).to receive(:email=).with 'one@digits.com' }

    its(:user) { should eq :user }
  end

  describe '#valid?' do
    context do
      before { allow(subject).to receive(:facebook_user).and_return nil }

      it { should_not be_valid }
    end

    context do
      before { allow(subject).to receive(:facebook_user).and_return({ 'id' => 1 }) }

      context do
        before { allow(User).to receive(:find_or_create_by).with(facebook_id: 1).and_return nil }

        it { should_not be_valid }
      end

      context do
        let(:user) { stub_model User }

        let(:auth_token) { double }

        before { allow(User).to receive(:find_or_create_by).with(facebook_id: 1).and_return user }

        before { expect(user).to receive(:auth_tokens).and_return auth_token }

        before { expect(auth_token).to receive(:build).and_return auth_token }

        context do
          before { expect(auth_token).to receive(:save).and_return false }

          it { should_not be_valid }
        end

        context do
          before { expect(auth_token).to receive(:save).and_return true }

          before { expect(auth_token).to receive(:value).and_return :auth_token }
          
          context do
            let(:user) { stub_model User, blocked_at: Time.now }

            it { should_not be_valid }
          end

          context do
            let(:user) { stub_model User, blocked_at: nil }

            it { should be_valid }
          end
        end
      end
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
end
