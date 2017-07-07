require 'rails_helper'

RSpec.describe ProductsController, type: :controller do 
  describe '#resource_params' do
    let(:params) do
      { product: { name: 'name', category_ids: ['1', '2', '3'], image: '' } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:product] }
  end

  it_behaves_like :index

  it_behaves_like :new

  it_behaves_like :show

  it_behaves_like :create do
    let(:resource) { double }

    let(:success) { -> { should redirect_to :products } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :destroy do
    let(:success) { -> { should redirect_to :products } }
  end
end
