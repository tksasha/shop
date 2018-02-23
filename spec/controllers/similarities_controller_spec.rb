require 'rails_helper'

RSpec.describe SimilaritiesController, type: :controller do
  let(:described_model) { Product }

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return({ product_id: 28}) }

      before { expect(SimilaritySearcher).to receive(:search).with(28).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  it_behaves_like :index, anonymous: true, params: { product_id: 1 }
end
