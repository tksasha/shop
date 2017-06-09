require 'rails_helper'

RSpec.describe BlocksController, type: :controller do
  it_behaves_like :create, params: { user_id: 1 } do
    let(:resource) { stub_model User }

    let(:success) { -> { expect(response).to have_http_status(:no_content) } }

    let(:failure) { -> { expect(response).to have_http_status(:no_content) } }
  end
end
