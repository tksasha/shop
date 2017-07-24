require 'rails_helper'

RSpec.describe ApplicationFactory do
  describe '#build' do
    subject { described_class.new :params }

    let(:resource_model) { double }

    before { expect(subject).to receive(:resource_model).and_return(resource_model) }

    before { expect(resource_model).to receive(:new).with(:params).and_return(:resource) }

    its(:build) { should eq :resource }
  end

  describe '.build' do
    subject { described_class.build :params }

    before do
      #
      # described_class.new(:params).build
      #
      expect(described_class).to receive(:new).with(:params) do
        double.tap { |a| expect(a).to receive(:build) }
      end
    end

    it { expect { subject }.to_not raise_error }
  end
end
