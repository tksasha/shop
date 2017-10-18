require 'rails_helper'

describe ProductSearcher do
  it_behaves_like :search_by_attributes, attributes: [:name, :description]

  describe '#search_by_category_id' do
    let(:collection) { double }

    before { expect(Product).to receive(:all).and_return(collection) }

    before do
      #
      # collection.joins(:categories).where(categories: { slug: 1201 }) -> :collection
      #
      expect(collection).to receive(:joins).with(:categories) do
        double.tap { |a| expect(a).to receive(:where).with(categories: { slug: 1201 }).and_return(:collection) }
      end
    end

    subject { described_class.search category_id: 1201 }

    it { should eq :collection }
  end
end
