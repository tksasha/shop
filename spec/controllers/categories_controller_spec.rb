require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(:params) }

      before { expect(CategorySearcher).to receive(:search).with(:params).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  it_behaves_like :index, skip_authenticate: true
end
