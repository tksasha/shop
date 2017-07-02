require 'rails_helper'

describe SessionPolicy do
  subject { described_class }

  permissions :new? do
    let(:resource) { double }

    context do
      let(:user) { nil }

      it { should permit user, resource }
    end

    context do
      let(:user) { double }

      it { should_not permit user, resource }
    end
  end

  permissions :create? do
    let(:resource) { double }

    context do
      let(:user) { nil }

      context do
        before { expect(resource).to receive(:user_blocked?).and_return(false) }

        context do
          before { expect(resource).to receive(:user_confirmed?).and_return(true) }

          it { should permit user, resource }
        end

        context do
          before { expect(resource).to receive(:user_confirmed?).and_return(false) }

          it { should_not permit user, resource }
        end
      end

      context do
        before { expect(resource).to receive(:user_blocked?).and_return(true) }

        it { should_not permit user, resource }
      end
    end

    context do
      let(:user) { double }

      it { should_not permit user, resource }
    end
  end

  permissions :destroy? do
    let(:resource) { double }

    context do
      let(:user) { double }

      it { should permit user, resource }
    end

    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end
  end
end
