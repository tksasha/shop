require 'rails_helper'

describe ProductSearcher do
  let(:relation) { Product.all }

  subject { described_class.new relation }

  describe '#search_by_name' do
    before { expect(relation).to receive(:search_by_name).with(:name).and_return(:result) }

    it { expect(subject.search_by_name :name).to eq(:result) }
  end

  describe '#search_by_description' do
    before { expect(relation).to receive(:search_by_description).with(:description).and_return(:result) }

    it { expect(subject.search_by_description :description).to eq(:result) }
  end

  describe '#search_by_category_id' do
    before do
      #
      # relation.joins(:categories).where(categories: { slug: 1201 }) -> :result
      #
      expect(relation).to receive(:joins).with(:categories) do
        double.tap { |a| expect(a).to receive(:where).with(categories: { slug: 1201 }).and_return(:result) }
      end
    end

    it { expect(subject.search_by_category_id 1201).to eq(:result) }
  end
end
