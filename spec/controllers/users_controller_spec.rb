require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it_behaves_like :new

  it_behaves_like :show do
    before { expect(subject).to receive(:authorize_user) }
  end

  it_behaves_like :create do
    let(:resource) { stub_model User }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end
end
