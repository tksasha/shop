require 'rails_helper'

describe ProductPolicy do
  subject { described_class }

  permissions :index?, :show? do
    let(:resource) { double }

    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { User.new }

      it { should permit user, resource }
    end
  end

  permissions :new?, :create?, :destroy? do
    let(:resource) { double }

    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { User.new }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { User.new roles: :admin }

      it { should permit user, resource }
    end
  end
end
