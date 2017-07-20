require 'rails_helper'

RSpec.describe PurchaseFactory do
  let(:params) { { user_id: 1, product_id: product.id, amount: 3, price: product.price } }

  let(:product) { stub_model Product, price: 4 }

  subject { described_class.new params[:user_id], product_id: params[:product_id], amount: params[:amount] }

  describe '#build' do
    before { expect(Purchase).to receive(:new).with(params).and_return(:resource) }

    before { expect(subject).to receive(:product).and_return(product) }

    its(:build) { should eq :resource }
  end

  describe '#product' do
    before { expect(Product).to receive(:find).with(params[:product_id]).and_return(product) }

    its(:product) { should eq product }
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
