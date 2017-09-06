require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe '#resource_params' do
    context do
      let(:params) do
        { user: { email: 'one@digits.com', password: 'password', password_confirmation: 'password' } }
      end

      before { expect(subject).to receive(:action_name).and_return('create') }

      before { expect(subject).to receive(:params).and_return(acp params) }

      its(:resource_params) { should eq permit! params[:user] }
    end

    context do
      let(:params) do
        { user: { currency: 'usd' } }
      end

      before { expect(subject).to receive(:action_name).and_return('update') }

      before { expect(subject).to receive(:params).and_return(acp params) }

      its(:resource_params) { should eq permit! params[:user] }
    end
  end

  it_behaves_like :new, skip_authenticate: true

  it_behaves_like :show

  it_behaves_like :create, skip_authenticate: true do
    let(:resource) { double }

    let(:success) { -> { should redirect_to :confirmations } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :edit

  it_behaves_like :update do
    let(:resource) { double }

    let(:success) { -> { should redirect_to :profile } }

    let(:failure) { -> { should render_template :edit } }
  end
end
