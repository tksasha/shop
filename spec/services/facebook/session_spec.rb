require 'rails_helper'

RSpec.describe Facebook::Session, type: :model do
  subject { described_class.new access_token: 'access_token'  }

  it { should validate_presence_of :access_token }

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

  describe '#access_token_must_be_valid' do
    let(:call) { -> { subject.send :access_token_must_be_valid } }

    context do
      before { allow(subject).to receive(:response).and_return('id' => 1) }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      before { allow(subject).to receive(:response).and_return({}) }

      it { expect(&call).to change { subject.errors.details }.to(access_token: [{ error: :invalid }]) }
    end

    context do
      before { allow(subject).to receive(:response).and_return('id' => nil) }

      it { expect(&call).to change { subject.errors.details }.to(access_token: [{ error: :invalid }]) }
    end
  end

  describe '#user' do
    context do
      let(:user) { double }

      before { allow(subject).to receive(:response).and_return({ 'id' => 1, 'email' => 'one@digits.com' }) }

      before { expect(User).to receive(:find_or_create_by).with(facebook_id: 1).and_yield(user).and_return(:user) }

      before { expect(user).to receive(:email=).with('one@digits.com') }

      its(:user) { should eq :user }
    end

    context do
      before { allow(subject).to receive(:response).and_return({}) }

      its(:user) { should be_nil }
    end

    context do
      before { allow(subject).to receive(:response).and_return('id' => nil) }

      its(:user) { should be_nil }
    end
  end
end
