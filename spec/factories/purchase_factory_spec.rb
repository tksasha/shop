require 'rails_helper'

RSpec.describe PurchaseFactory do
  let(:product) { stub_model Product, price: 4 }

  let(:params) { { user_id: 1, product_id: product.id, amount: 3, price: 12 } }

  subject { described_class.new params[:user_id], product_id: params[:product_id], amount: params[:amount] }

  describe '#params' do
    before { expect(subject).to receive(:price).and_return 12 }

    its(:params) { should eq params }
  end

  describe '#product' do
    before { expect(Product).to receive(:find).with(params[:product_id]).and_return(product) }

    its(:product) { should eq product }
  end

  describe '#price' do
    before { expect(subject).to receive(:product_price).and_return(3) }

    its(:price) { should eq 9 }
  end

  describe '#product_price' do
    before { expect(subject).to receive(:product).and_return(product).twice }

    context do
      its(:product_price) { should eq 4 }
    end

    context do
      let(:product) { stub_model Product, price: 4, discount_price: 2 }

      its(:product_price) { should eq 2 }
    end
  end
end
