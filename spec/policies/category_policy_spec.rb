require 'rails_helper'

describe CategoryPolicy do
  subject { described_class }

  permissions :new?, :create? do
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
      let(:user) { User.new roles: [:admin] }

      it { should permit user, resource }
    end
  end

  permissions :index? do
    let(:resource) { double }

    let(:user) { nil }

    it { should permit user, resource }
  end
end
