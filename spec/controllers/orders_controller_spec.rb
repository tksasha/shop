require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    its(:resource) { should be_nil }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    before { expect(OrderFactory).to receive(:build).with(:current_user).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  it_behaves_like :create do
    let(:resource) { double }

    let(:success) { -> { should render_template(:create).with_status(201) } }

    let(:failure) { -> { should render_template(:errors).with_status(400) } }
  end
end
