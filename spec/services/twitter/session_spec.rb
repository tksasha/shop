require 'rails_helper'

RSpec.describe Twitter::Session, type: :model do
  subject { described_class.new oauth_token: 'ABCD-EFGH-IJKL-MNOP', oauth_token_secret: 'KLMN-OPQR-STUV-WXYZ' }

  its(:oauth_token) { should eq 'ABCD-EFGH-IJKL-MNOP' }

  its(:oauth_token_secret) { should eq 'KLMN-OPQR-STUV-WXYZ' }

  it { should validate_presence_of :oauth_token }

  it { should validate_presence_of :oauth_token_secret }

  its(:token_hash) { should eq oauth_token: 'ABCD-EFGH-IJKL-MNOP', oauth_token_secret: 'KLMN-OPQR-STUV-WXYZ' }

  describe '#consumer' do
    before { expect(ENV).to receive(:[]).with('TWITTER_API_KEY').and_return(:key) }

    before { expect(ENV).to receive(:[]).with('TWITTER_API_SECRET').and_return(:secret) }

    before do
      expect(OAuth::Consumer).to receive(:new).with(:key, :secret, { site: 'https://api.twitter.com', scheme: :header }).
        and_return(:consumer)
    end

    its(:consumer) { should eq :consumer }
  end

  describe '#access_token' do
    before { expect(subject).to receive(:consumer).and_return(:consumer) }

    before { expect(subject).to receive(:token_hash).and_return(:token_hash) }

    before { expect(OAuth::AccessToken).to receive(:from_hash).with(:consumer, :token_hash).and_return(:access_token) }

    its(:access_token) { should eq :access_token }
  end

  describe '#response' do
    context do
      before { subject.instance_variable_set :@response, :response }

      its(:response) { should eq :response }
    end

    context do
      before do
        expect(subject).to receive_message_chain(:access_token, :request).
          with(:get, 'https://api.twitter.com/1.1/account/verify_credentials.json').and_return(:response)
      end

      its(:response) { should eq :response }
    end
  end

  describe '#response_must_be_valid' do
    let(:call) { -> { subject.send :response_must_be_valid } }

    context do
      let(:response) { Net::HTTPUnauthorized.new 1.1, 401, 'Authorization Required' }

      before { expect(subject).to receive(:response).and_return(response) }

      it do
        expect(&call).to change { subject.errors.details }.
          to(oauth_token: [{ error: :invalid }], oauth_token_secret: [{ error: :invalid }])
      end
    end

    context do
      let(:response) { Net::HTTPOK.new 1.1, 200, 'OK' }

      before { expect(subject).to receive(:response).and_return(response) }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      subject { described_class.new oauth_token: nil, oauth_token_secret: 'ABCD-EFGH-IJKL-MNOP' }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      subject { described_class.new oauth_token: 'ABCD-EFGH-IJKL-MNOP', oauth_token_secret: nil }

      it { expect(&call).to_not change { subject.errors.details } }
    end
  end

  describe '#valid?' do
    before { expect(subject).to receive(:response_must_be_valid) }

    it { expect { subject.valid? }.to_not raise_error }
  end

  describe '#user' do
    context do
      let(:user) { double }

      let(:response) { Net::HTTPOK.new 1.1, 200, 'OK' }

      let(:body) { '{"id_str":"1","email":"one@digits.com"}' }

      before { expect(response).to receive(:body).and_return(body) }

      before { expect(subject).to receive(:response).twice.and_return(response) }

      before { expect(User).to receive(:find_or_create_by).with(twitter_id: '1').and_yield(user).and_return(:user) }

      before { expect(user).to receive(:email=).with('one@digits.com') }

      its(:user) { should eq :user }
    end

    context do
      let(:response) { Net::HTTPUnauthorized.new 1.1, 401, 'Authorization Required' }

      before { expect(subject).to receive(:response).and_return(response) }

      its(:user) { should be_nil }
    end
  end
end
