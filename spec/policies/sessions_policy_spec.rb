require 'rails_helper'

describe SessionPolicy do
  subject { described_class }

  permissions :new?, :create? do
    context do
      let(:user) { nil }

      let(:resource) { User.new blocked: false }

      it { should permit user, resource }
    end

    context do
      let(:user) { nil }

      let(:resource) { User.new blocked: true }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { User.new }

      let(:resource) { double }

      it { should_not permit user, resource }
    end
  end

  permissions :destroy? do
    let(:resource) { double }

    context do
      let(:user) { User.new }

      it { should permit user, resource }
    end

    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end
  end
end