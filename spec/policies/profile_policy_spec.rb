require 'rails_helper'

describe ProfilePolicy do
  subject { described_class }

  permissions :new?, :create? do
    it { expect(subject).to permit(nil, Profile.new(email: 'one@digits.com', password: 'password', password_confirmation: 'password')) }
  end

  permissions :show? do
    context do
      it { expect(subject).to permit(Profile.new(id: 1), Profile.new(id: 1)) }
    end

    context do
      it { expect(subject).not_to permit(Profile.new(id: 1), Profile.new(id: 2)) }
    end
  end
end