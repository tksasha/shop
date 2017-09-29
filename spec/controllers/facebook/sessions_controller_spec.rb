require 'rails_helper'

RSpec.describe Facebook::SessionsController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      { session: { access_token: 'access_token' } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:session] }
  end

  describe '#login_user' do
    let(:resource) { double }

    before { allow(subject).to receive(:resource).and_return resource }

    context do
      before { expect(resource).to receive(:persisted?).and_return true }

      before { expect(resource).to receive(:auth_token).and_return 1 }

      after { expect(subject.session[:auth_token]).to eq 1 }

      its(:login_user) { should eq 1 }
    end

    context do
      before { expect(resource).to receive(:persisted?).and_return false }

      after { expect(subject.session[:auth_token]).to eq nil }

      its(:login_user) { should eq nil }
    end
  end

  it_behaves_like :create, skip_authenticate: true, format: :json do
    let(:resource) { double }

    before { expect(subject).to receive(:login_user) }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :errors } }
  end
end
