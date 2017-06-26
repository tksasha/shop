require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      { user: { email: 'one@digits.com', password: 'password', password_confirmation: 'password' } }
    end

    before { expect(subject).to receive(:params).and_return(acp params) }

    its(:resource_params) { should eq permit! params[:user] }
  end

  describe '#login_user' do
    let (:resource) { double }

    before { allow(subject).to receive(:resource).and_return(resource) }

    context do
      before { expect(resource).to receive(:new_record?).and_return(false) }

      before { expect(resource).to receive(:id).and_return(1) }

      after { expect(subject.session[:user_id]).to eq 1 }

      its(:login_user) { should eq 1 }
    end

    context do
      before { expect(resource).to receive(:new_record?).and_return(true) }

      after { expect(subject.session[:user_id]).to eq nil }

      its(:login_user) { should eq nil }
    end
  end

  it_behaves_like :new, skip_authenticate_user: true

  it_behaves_like :show

  it_behaves_like :create, skip_authenticate_user: true do

    let(:resource) { double }

    before { expect(subject).to receive(:login_user) }

    let(:success) { -> { should redirect_to :profile } }

    let(:failure) { -> { should render_template :new } }
  end
end
