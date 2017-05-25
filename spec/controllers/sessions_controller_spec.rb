require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      { session: { email: 'one@digits.com', password: 'password' } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:session] }
  end

  it_behaves_like :new

  it_behaves_like :create do
    let(:resource) { stub_model Session }

    before { expect(subject).to receive(:login_user) }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end
end
