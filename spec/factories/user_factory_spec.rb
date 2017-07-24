require 'rails_helper'

RSpec.describe UserFactory do
  subject { described_class.new email: 'one@digits.com', password: 'password' }

  describe '#params' do
    let(:params) { { email: 'one@digits.com', password: 'password', roles: :user, confirmation_token: :uuid } }

    before { expect(SecureRandom).to receive(:uuid).and_return(:uuid) }

    its(:params) { should eq params }
  end
end
