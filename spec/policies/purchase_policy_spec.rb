require 'rails_helper'

describe PurchasePolicy do
  subject { described_class }

  permissions :create? do
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

  permissions :update?, :destroy? do
    context do
      let(:user) { nil }

      let(:resource) { double }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, id: 1 }

      context do
        let(:resource) { stub_model Purchase, user_id: 2 }

        it { should_not permit user, resource }
      end

      context do
        let(:resource) { stub_model Purchase, user_id: 1 }

        it { should permit user, resource }
      end
    end
  end
end
