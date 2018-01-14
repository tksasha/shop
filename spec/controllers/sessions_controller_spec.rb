require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      { session: { email: 'one@digits.com', password: 'password' } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:session] }
  end

  describe '#login_user' do
    let(:resource) { double }

    before { allow(subject).to receive(:resource).and_return(resource) }

    context do
      before { expect(resource).to receive(:persisted?).and_return(true) }

      before { expect(resource).to receive(:auth_token).and_return(1) }

      after { expect(subject.session[:auth_token]).to eq 1 }

      its(:login_user) { should eq 1 }
    end

    context do
      before { expect(resource).to receive(:persisted?).and_return(false) }

      after { expect(subject.session[:auth_token]).to eq nil }

      its(:login_user) { should eq nil }
    end
  end

  describe '#logout_user' do
    let(:resource) { double }

    before { expect(subject).to receive(:resource).and_return(resource) }

    context do
      before { subject.session[:auth_token] = 1 }

      before { expect(resource).to receive(:destroyed?).and_return(true) }

      before { subject.send(:logout_user) }

      it { expect(subject.session[:auth_token]).to eq nil }
    end

    context do
      before { subject.session[:auth_token] = 1 }

      before { expect(resource).to receive(:destroyed?).and_return(false) }

      before { subject.send(:logout_user) }

      it { expect(subject.session[:auth_token]).to eq 1 }
    end
  end

  it_behaves_like :create, skip_authenticate: true, format: :json do

    let(:resource) { double }

    before { expect(subject).to receive(:login_user) }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :errors } }
  end

  it_behaves_like :destroy, format: :json do
    before { expect(subject).to receive(:logout_user) }

    let(:success) { -> { should respond_with(:no_content) } }
  end
end
