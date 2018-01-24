require 'rails_helper'

RSpec.describe Twitter::SessionsController, type: :controller do
  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    its(:resource) { should be_nil }
  end

  describe '#resource_params' do
    let(:params) { acp session: { oauth_token: 'ABCD-EFGH-IJKL-MNOP', oauth_token_secret: 'KLMN-OPQR-STUV-WXYZ' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:session].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:params) }

    before { expect(Twitter::Session).to receive(:new).with(:params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  describe '#policy' do
    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    before { expect(SessionPolicy).to receive(:new).with(:current_user, nil).and_return(:policy) }

    its(:policy) { should eq :policy }
  end

  it_behaves_like :create, skip_authenticate: true, policy: SessionPolicy do
    let(:resource) { double }

    let(:success) { -> { should render_template(:create).with_status(201) } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end
end
