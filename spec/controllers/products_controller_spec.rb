require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  it_behaves_like :index

  it_behaves_like :show

  it_behaves_like :destroy do
    let(:success) { -> { should redirect_to :products } }
  end
end
