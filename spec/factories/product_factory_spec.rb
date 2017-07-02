require 'rails_helper'

RSpec.describe ProductFactory do
  describe '#build' do
    subject { described_class.new name: 'name', categories: ['1', '2', '3'] }

    before { expect(Category).to receive(:find).with(['1', '2', '3']).and_return(:categories) }

    before { expect(Product).to receive(:new).with(name: 'name', categories: :categories).and_return(:resource) }

    its(:build) { should eq :resource }
  end

  describe '.build' do
    before do
      #
      # described_class.new(:params).build
      #
      expect(described_class).to receive(:new).with(:params) do
        double.tap { |a| expect(a).to receive(:build) }
      end
    end

    subject { described_class.build :params }

    it { expect { subject }.to_not raise_error }
  end
end
