require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe '#resource' do
    before { expect(subject).to receive(:params).and_return(id: 1136) }

    before { expect(Category).to receive(:find_by!).with(slug: 1136).and_return(:category) }

    its(:resource) { should eq :category }
  end

  it_behaves_like :index, format: :json
end
