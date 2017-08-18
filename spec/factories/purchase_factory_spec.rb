require 'rails_helper'

RSpec.describe PurchaseFactory do
  let :product { stub_model Product, price: 4 }

  let :params { { user_id: 1, product_id: product.id, amount: 3, price: product.price * 3 } }

  subject { described_class.new params[:user_id], product_id: params[:product_id], amount: params[:amount] }

  describe '#params' do
    before { expect(subject).to receive(:product).and_return(product) }

    its :params { should eq params }
  end

  describe '#product' do
    before { expect(Product).to receive(:find).with(params[:product_id]).and_return(product) }

    its :product { should eq product }
  end

  describe '#price' do
    before { expect(subject).to receive(:product).and_return(product) }

    its :price { should eq 12 }
  end
end
