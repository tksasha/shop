require 'rails_helper'

RSpec.describe Similarities do
  let :product { stub_model Product, id: 4, similarities: [{ product_id: 1, amount: 1 }, { product_id: 3, amount: 3 }] }

  let :purchases do
    [
      Purchase.new(product_id: 1, amount: 1, price: 1.1),
      Purchase.new(product_id: 2, amount: 2, price: 2.2),
      Purchase.new(product_id: 3, amount: 3, price: 3.3),
      Purchase.new(product_id: 4, amount: 4, price: 4.4)
    ]
  end

  let :order { double purchases: purchases }

  subject { described_class.new product, order }

  its :purchases { should eq [{ product_id: 1, amount: 1 }, { product_id: 2, amount: 2 }, { product_id: 3, amount: 3 }] }

  describe '#source_similarities' do
    its :source_similarities { should eq [{ product_id: 1, amount: 1 }, { product_id: 3, amount: 3 }] }

    context do
      let :product { stub_model Product }

      its :source_similarities { should eq [] }
    end
  end

  its :source_similarities_hash { should eq 1 => 1, 3 => 3 }

  its :merged_similarities_hash { should eq 1 => 2, 2 => 2, 3 => 6 }

  its :merged_similarities do
    should eq [{ product_id: 1, amount: 2 }, { product_id: 3, amount: 6 }, { product_id: 2, amount: 2 }]
  end

  describe '#update!' do
    before do
      expect(product).to receive(:update!).
        with(similarities: [{ product_id: 1, amount: 2 }, { product_id: 3, amount: 6 }, { product_id: 2, amount: 2 }])
    end

    it { expect { subject.update! }.to_not raise_error }
  end

  describe '.update!' do
    before do
      #
      # described_class.new(:product, :order).update!
      #
      expect(described_class).to receive(:new).with(:product, :order) do
        double.tap { |a| expect(a).to receive(:update!) }
      end
    end

    subject { described_class.update! :product, :order }

    it { expect { subject }.to_not raise_error }
  end
end
