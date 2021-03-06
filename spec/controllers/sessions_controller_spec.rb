require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:auth_token).and_return(:auth_token) }

      before { expect(AuthToken).to receive(:find).with(:auth_token).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let(:params) { acp session: { email: 'one@digits.com', password: 'password' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:session].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:params) }

    before { expect(Session).to receive(:new).with(:params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  it_behaves_like :create, anonymous: true do
    let(:resource) { double }

    let(:success) { -> { should render_template(:create).with_status(201) } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  describe '#policy' do
    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    before { expect(SessionPolicy).to receive(:new).with(:current_user, nil).and_return(:policy) }

    its(:policy) { should eq :policy }
  end

  it_behaves_like :destroy do
    let(:success) { -> { should respond_with 204 } }
  end
end
