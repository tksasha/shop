require 'rails_helper'

describe UserSessionPolicy do
  subject { described_class }

  permissions :new? do
    let(:resource) { double }

    context do
      let(:user) { nil }

      it { should permit user, resource }
    end

    context do
      let(:user) { User.new }

      it { should_not permit user, resource }
    end
  end

  permissions :create? do
    let(:resource) { double }

    context do
      let(:user) { nil }

      before { expect(resource).to receive(:user_blocked?).and_return(false) }

      it { should permit user, resource }
    end

    context do
      let(:user) { nil }

      before { expect(resource).to receive(:user_blocked?).and_return(true) }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { User.new }

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