require 'rails_helper'

describe BlockPolicy do
  subject { described_class }

  permissions :create?, :destroy? do
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
end
