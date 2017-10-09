require 'rails_helper'

RSpec.describe Facebook::Session, type: :model do
  subject { described_class.new access_token: 'access_token'  }

  it { should validate_presence_of :access_token }

  describe '#response' do
    context do
      let(:response) { double read: '{ "id": 1, "email": "one@digits.com" }' }

      before do
        expect(subject).to receive(:open).
          with('https://graph.facebook.com/me?fields=id,email&access_token=access_token').
          and_return response
      end

      its(:response) { should eq({ 'id' => 1, 'email' => 'one@digits.com' }) }
    end

    context do
      before do
        expect(subject).to receive(:open).
          with('https://graph.facebook.com/me?fields=id,email&access_token=access_token').
          and_raise OpenURI::HTTPError.new('message', nil)
      end

      its(:response) { should be_empty }
    end
  end

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return false }

      before { expect(subject).to_not receive :find_or_create_user }

      before { expect(subject).to_not receive :create_auth_token }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      before { expect(subject).to receive(:find_or_create_user).and_return true }

      before { expect(subject).to receive(:create_auth_token).and_return true }

      its(:save) { should eq true }
    end
  end

  describe '#persisted?' do
    context do
      before { subject.instance_variable_set :@persisted, true }

      its(:persisted?) { should eq true }
    end

    context do
      before { subject.instance_variable_set :@persisted, false }

      its(:persisted?) { should eq false }
    end

    context do
      before { subject.instance_variable_set :@persisted, nil }

      its(:persisted?) { should eq false }
    end
  end

  describe '#access_token_must_be_valid' do
    context do
      before { expect(subject).to receive(:response).and_return({}) }

      before { subject.valid? }

      it { expect(subject.errors[:access_token]).to include I18n.t('errors.messages.invalid') }
    end

    context do
      before { expect(subject).to receive(:response).and_return({ 'id' => 1 }) }

      before { subject.valid? }

      it { expect(subject.errors[:access_token]).to_not include I18n.t('errors.messages.invalid') }
    end
  end

  describe '#find_or_create_user' do
    let(:user) { double }

    before { expect(subject).to receive(:response).and_return({ 'id' => 1, 'email' => 'one@digits.com' }).twice }

    before { expect(User).to receive(:find_or_create_by).with(facebook_id: 1).and_yield(user).and_return :user }

    before { expect(user).to receive(:email=).with 'one@digits.com' }

    before { subject.send :find_or_create_user }

    its(:user) { should eq :user }
  end

  describe '#create_auth_token' do
    before { expect(subject).to receive(:auth_token).and_return :auth_token }

    before do
      #
      # subject.user.auth_tokens.create value: :auth_token
      #
      expect(subject).to receive(:user) do
        double.tap do |user|
          expect(user).to receive(:auth_tokens) do
            double.tap do |auth_tokens|
              expect(auth_tokens).to receive(:create).with value: :auth_token
            end
          end
        end
      end
    end

    it { expect { subject.send :create_auth_token }.to_not raise_error }
  end
end
