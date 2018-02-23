require 'rails_helper'

RSpec.describe ConfirmationsController, type: :controller do
  describe '#resource_params' do
    let(:params) { acp confirmation: { token: 'XXX-YYY-ZZZ' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:confirmation].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:params) }

    before { expect(Confirmation).to receive(:new).with(:params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  it_behaves_like :create, anonymous: true do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end
end
