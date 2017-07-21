require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  it_behaves_like :create, format: :json do
    let(:resource) { double }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :errors } }
  end
end
