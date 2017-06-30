require 'rails_helper'

RSpec.describe UserDecorator do
  subject { user.decorate }

  let(:datetime) { DateTime.new 2001, 2, 3, 4, 5, 6 }

  describe 'blocked?' do
    context do
      let(:user) { stub_model User, blocked_at: datetime }

      its(:blocked?) { should eq true }
    end

    context do
      let(:user) { stub_model User }

      its(:blocked?) { should eq false }
    end
  end

  describe 'blocked_at' do
    context do
      let(:user) { stub_model User, blocked_at: datetime }

      its(:blocked_at) { should eq '03 Feb 01, 04:05' }
    end

    context do
      let(:user) { stub_model User }

      its(:blocked_at) { should eq 'False' }
    end
  end
end
