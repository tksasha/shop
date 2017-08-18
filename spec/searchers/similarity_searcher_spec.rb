require 'rails_helper'

RSpec.describe SimilaritySearcher do
  let(:product) { stub_model Product, id: 49 }

  subject { described_class.new product }

  its(:product_id) { should eq 49 }

  describe '#search' do
    before do
      #
      # Product.
      #   from('products AS t1, jsonb_to_recordset(t1.similarities) AS similarities(product_id integer, amount integer)').
      #   joins('INNER JOIN products ON products.id=similarities.product_id').
      #   where('t1.id = ? ', 49).
      #   order('similarities.amount DESC') -> :collection
      #
      expect(Product).to receive(:from).
        with('products AS t1, jsonb_to_recordset(t1.similarities) AS similarities(product_id integer, amount integer)') do
        double.tap do |a|
          expect(a).to receive(:joins).with('INNER JOIN products ON products.id=similarities.product_id') do
            double.tap do |b|
              expect(b).to receive(:where).with('t1.id = ? ', 49) do
                double.tap { |c| expect(c).to receive(:order).with('similarities.amount DESC').and_return(:collection) }
              end
            end
          end
        end
      end
    end

    its(:search) { should eq :collection }
  end

  describe '.search' do
    before do
      #
      # described_class.new(product).search -> :collection
      #
      expect(described_class).to receive(:new).with(product) do
        double.tap { |a| expect(a).to receive(:search).and_return(:collection) }
      end
    end

    subject { described_class.search product }

    it { should eq :collection }
  end
end
