require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 12) }

      before { expect(Purchase).to receive(:find).with(12).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let(:params) { acp purchase: { amount: 1, product_id: 1 } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:purchase].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive_message_chain(:current_user, :id).and_return(36) }

    before { expect(subject).to receive(:resource_params).and_return(:params) }

    before { expect(PurchaseFactory).to receive(:build).with(36, :params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  it_behaves_like :create do
    let(:resource) { double }

    let(:success) { -> { should render_template(:create).with_status(201) } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  it_behaves_like :update do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  it_behaves_like :destroy do
    let(:success) { -> { should respond_with 204 } }
  end
end
