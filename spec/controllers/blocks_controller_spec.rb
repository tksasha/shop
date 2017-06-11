require 'rails_helper'

RSpec.describe BlocksController, type: :controller do
  it_behaves_like :create, params: { user_id: 1 }, format: :js do
    let(:resource) { stub_model User }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :errors } }
  end
end
