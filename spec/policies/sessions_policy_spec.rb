require 'rails_helper'

describe SessionPolicy do
  subject { described_class }

  permissions :new?, :create?, :show? do
    it { expect(subject).to permit(nil, Session.new(email: 'one@digits.com', password: 'password')) }
  end
end