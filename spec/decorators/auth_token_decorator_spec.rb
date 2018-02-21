require 'rails_helper'

RSpec.describe AuthTokenDecorator do
  let(:auth_token) { stub_model AuthToken, id: 'c378231b-f7e0-4ec5-95fc-66f007ce283c' }

  subject { auth_token.decorate }

  describe '#as_json' do
    before { expect(auth_token).to receive(:user).and_return(:user) }

    its(:as_json) { should eq auth_token: 'c378231b-f7e0-4ec5-95fc-66f007ce283c', user: :user }
  end
end
