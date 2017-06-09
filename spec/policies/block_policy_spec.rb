require 'rails_helper'

describe BlockPolicy do
  subject { described_class }

  permissions :create? do
    context do
      let(:user) { nil }

      let(:resource) { double }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { User.new }

      let(:resource) { double }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { User.new roles: [:admin] }

      let(:resource) { double }

      it { should permit user, resource }
    end
  end
end
