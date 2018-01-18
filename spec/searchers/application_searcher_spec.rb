require 'rails_helper'

describe ApplicationSearcher do
  let(:relation) { double }

  let(:params) { { attribute: :value } }

  subject { described_class.new relation, params }

  describe '#search' do
    context do
      before { def subject.search_by_attribute value; end }

      before { expect(subject).to receive(:search_by_attribute).with(:value).and_return(:result) }

      its(:search) { should eq :result }
    end

    context do
      let(:params) { nil }

      its(:search) { should eq relation }
    end
  end

  describe '.search' do
    it do
      #
      # described_class.new(params).search
      #
      expect(described_class).to receive(:new).with(:params) do
        double.tap { |a| expect(a).to receive(:search) }
      end
    end

    after { described_class.search :params }
  end
end
