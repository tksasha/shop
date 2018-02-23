require 'rails_helper'

describe VersionPolicy do
  subject { described_class }

  permissions :show? do
    let(:resource) { double }

    let(:user) { nil }

    it { should permit user, resource }
  end
end
