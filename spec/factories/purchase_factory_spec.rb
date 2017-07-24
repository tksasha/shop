require 'rails_helper'

RSpec.describe PurchaseFactory do
  let(:params) { { user_id: 1, product_id: product.id, amount: 3, price: product.price } }

  let(:product) { stub_model Product, price: 4 }

  subject { described_class.new params[:user_id], product_id: params[:product_id], amount: params[:amount] }

  describe '#params' do
    before { expect(subject).to receive(:product).and_return(product) }

    its(:params) { should eq params }
  end

  describe '#product' do
    before { expect(Product).to receive(:find).with(params[:product_id]).and_return(product) }

    its(:product) { should eq product }
  end
end
