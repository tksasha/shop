require 'rails_helper'

describe OrderPolicy do
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
end
