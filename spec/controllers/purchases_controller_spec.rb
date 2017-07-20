require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      { purchase: { amount: 1, product_id: 1 } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:purchase] }
  end

  it_behaves_like :create, format: :json do
    let(:resource) { double }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :errors } }
  end

  it_behaves_like :update, format: :json do
    let(:resource) { double }

    let(:success) { -> { should respond_with(:no_content)  } }

    let(:failure) { -> { should render_template :errors } }
  end

  it_behaves_like :destroy, format: :json do
    let(:success) { -> { should respond_with(:no_content) } }
  end
end
