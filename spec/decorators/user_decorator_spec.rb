require 'rails_helper'

RSpec.describe UserDecorator do
  subject { user.decorate }

  let(:user) do
    stub_model User,
      id: 43,
      email: 'one@users.com',
      roles: %i(user admin),
      currency: :usd,
      blocked_at: DateTime.new(2001, 2, 3, 4, 5, 6)
  end

  its(:as_json) do
    should eq id: 43,
      email: 'one@users.com',
      roles: %i(user admin),
      currency: 'usd'
  end

  describe '#blocked?' do
    its(:blocked?) { should eq true }

    context do
      let(:user) { stub_model User }

      its(:blocked?) { should eq false }
    end
  end

  describe '#blocked_at' do
    its(:blocked_at) { should eq '03 Feb 01, 04:05' }

    context do
      let(:user) { stub_model User }

      its(:blocked_at) { should eq 'False' }
    end
  end
end
