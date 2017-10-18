require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      { product: { name: 'name', category_ids: ['1', '2', '3'], image: '', price: 1, discount_price: 1, amount: 1 } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:product] }
  end

  it_behaves_like :index, skip_authenticate: true

  it_behaves_like :index, format: :json, skip_authenticate: true

  it_behaves_like :new

  it_behaves_like :show

  it_behaves_like :show, format: :pdf do
    let(:options) { WickedPdf.config.merge basic_auth: nil }

    before { expect(subject).to receive(:make_and_send_pdf).with('show', options) }
  end

  it_behaves_like :create do
    let(:resource) { stub_model Product }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :edit

  it_behaves_like :update do
    let(:resource) { stub_model Product }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :edit } }
  end

  it_behaves_like :edit, format: :js

    it_behaves_like :update, format: :js do
      let(:resource) { stub_model Product }

      let(:success) { -> { should render_template :update } }

      let(:failure) { -> { should render_template :edit } }
    end

  it_behaves_like :destroy do
    let(:success) { -> { should redirect_to :products } }
  end

  describe '#parent' do
    its(:parent) { should be_nil }

    context do
      before { expect(subject).to receive(:params).twice.and_return(category_id: 1136) }

      before { expect(Category).to receive(:find).with(1136).and_return(:category) }

      its(:parent) { should eq :category }
    end
  end
end
