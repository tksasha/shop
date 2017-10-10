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

      before { expect(subject).to_not receive :create_auth_token }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      context do
        before { expect(subject).to receive(:create_auth_token).and_return nil }

        its(:save) { should eq false }
      end

      context do
        before do
          #
          # subject.create_auth_token.persisted? -> false
          #
          expect(subject).to receive(:create_auth_token) do
            double.tap { |a| expect(a).to receive(:persisted?).and_return false }
          end
        end

        its(:save) { should eq false }
      end

      context do
        before do
          #
          # subject.create_auth_token.persisted? -> true
          #
          expect(subject).to receive(:create_auth_token) do
            double.tap { |a| expect(a).to receive(:persisted?).and_return true }
          end
        end

        its(:save) { should eq true }
      end
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

  describe '#user' do
    let(:user) { double }

    before { expect(subject).to receive(:response).and_return({ 'id' => 1, 'email' => 'one@digits.com' }).twice }

    before { expect(User).to receive(:find_or_create_by).with(facebook_id: 1).and_yield(user).and_return :user }

    before { expect(user).to receive(:email=).with 'one@digits.com' }

    its(:user) { should eq :user }
  end

  describe '#create_auth_token' do
    context do
      let(:user) { double }

      before { expect(subject).to receive(:auth_token).and_return :auth_token }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before do
        #
        # user.auth_tokens.create value: :auth_token -> :create_auth_token
        #
        expect(user).to receive(:auth_tokens) do
          double.tap do |a|
            expect(a).to receive(:create).with(value: :auth_token).and_return :create_auth_token
          end
        end
      end

      its(:create_auth_token) { should eq :create_auth_token }
    end

    context do
      before { expect(subject).to receive(:user).and_return nil }

      its(:create_auth_token) { should be_nil }
    end
  end
end
