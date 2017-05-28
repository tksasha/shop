require 'rails_helper'

describe UserPolicy do
  subject { described_class }

  permissions :new?, :create? do
    context do
      it { expect(subject).to permit(nil, User.new(email: 'one@digits.com', password: 'password', password_confirmation: 'password')) }
    end

    context do
      it { expect(subject).not_to permit(User.new(id: 1), User.new(email: 'one@digits.com', password: 'password', password_confirmation: 'password')) }
    end
  end

  permissions :show? do
    context do
      it { expect(subject).to permit(User.new(id: 1), User.new(id: 1)) }
    end

    context do
      it { expect(subject).not_to permit(User.new(id: 1), User.new(id: 2)) }
    end
  end
end