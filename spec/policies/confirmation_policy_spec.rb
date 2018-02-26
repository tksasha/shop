require 'rails_helper'

describe ConfirmationPolicy do
  subject { described_class }

  permissions :new?, :create? do
    let(:resource) { double }

    context do
      let(:user) { double }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { nil }

      it { should permit user, resource }
    end
  end
end
