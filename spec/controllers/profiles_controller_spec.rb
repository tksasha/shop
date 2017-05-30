require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      { user: { email: 'one@digits.com', password: 'password', password_confirmation: 'password' } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:user] }
  end

  it_behaves_like :login_user

  it_behaves_like :new

  it_behaves_like :show do
    before { expect(subject).to receive(:authenticate_user) }
  end

  it_behaves_like :create do
    let(:resource) { double }

    before { expect(subject).to receive(:login_user) }

    let(:success) { -> { should redirect_to :profile } }

    let(:failure) { -> { should render_template :new } }
  end
end
