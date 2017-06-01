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
    let (:resource) { double }

    before { allow(subject).to receive(:resource).and_return(resource) }

    context do
      before { expect(resource).to receive(:persisted?).and_return(true) }

      before { expect(resource).to receive(:user_id).and_return(1) }

      after { expect(subject.session[:user_id]).to eq 1 }

      its(:login_user) { should eq 1 }
    end

    context do
      before { expect(resource).to receive(:persisted?).and_return(false) }

      after { expect(subject.session[:user_id]).to eq nil }

      its(:login_user) { should eq nil }
    end
  end

  describe '#logout_user' do
    let (:resource) { double }

    before { expect(subject).to receive(:resource).and_return(resource) }

    context do
      before { subject.session[:user_id] = 1 }

      before { expect(resource).to receive(:destroyed?).and_return(true) }

      before { subject.send(:logout_user) }

      it { expect(subject.session[:user_id]).to eq nil }
    end

    context do
      before { subject.session[:user_id] = 1 }

      before { expect(resource).to receive(:destroyed?).and_return(false) }

      before { subject.send(:logout_user) }

      it { expect(subject.session[:user_id]).to eq 1 }
    end
  end

  it_behaves_like :new

  it_behaves_like :create do
    let(:resource) { double }

    before { expect(subject).to receive(:login_user) }

    let(:success) { -> { should redirect_to :profile } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :destroy do
    before { expect(subject).to receive(:logout_user) }

    let(:success) { -> { should redirect_to [:new, :profile] } }
  end
end