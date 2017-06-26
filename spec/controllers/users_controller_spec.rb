require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it_behaves_like :index

  it_behaves_like :edit

  it_behaves_like :update do
    let(:resource) { double }

    let(:success) { -> { should redirect_to :users } }

    let(:failure) { -> { should render_template :edit } }
  end
end
