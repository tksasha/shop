require 'rails_helper'

RSpec.describe ProductsController, type: :controller do 
  describe '#index' do
    before { expect(Product).to receive(:all).and_return(:products) }

    its(:index) { should eq :products }
  end
end
