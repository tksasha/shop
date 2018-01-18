require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(:params) }

      before { expect(Category).to receive(:order).with(:slug).and_return(:relation) }

      before { expect(CategorySearcher).to receive(:search).with(:relation, :params).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  it_behaves_like :index
end
