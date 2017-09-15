require 'rails_helper'

describe ApplicationSearcher do
  describe '#search' do
    class Dummy < described_class
      def search_by_attr1 val; end

      def search_by_attr2 val; end

      def search_by_attr3 val; end
    end

    let(:params) { { attr1: 'val1', attr2: 'val2', attr3: nil } }

    subject { Dummy.new params }

    before do
      #
      # subject.resource_model.all => :results
      #
      expect(subject).to receive(:resource_model) do
        double.tap { |a| expect(a).to receive(:all).and_return(:results) }
      end
    end

    before { expect(subject).to receive(:search_by_attr1).with('val1') }

    before { expect(subject).to receive(:search_by_attr2).with('val2') }

    its(:search) { should eq :results }
  end

  describe '.search' do
    before do
      #
      # described_class.new(params).search
      #
      expect(described_class).to receive(:new).with(:params) do
        double.tap { |a| expect(a).to receive(:search) }
      end
    end

    it { expect { described_class.search :params }.to_not raise_error }
  end

  describe '.search_by_attributes' do
    subject { described_class.send :search_by_attributes, :attr1, :attr2 }

    it do
      expect { subject } .to change { described_class.private_instance_methods } .by [:search_by_attr1, :search_by_attr2]
    end
  end
end
