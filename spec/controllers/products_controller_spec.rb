require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      let(:params) { { page: :page, param: :value } }

      before { expect(subject).to receive(:params).twice.and_return(params) }

      before do
        #
        # Product.order(:name).page(:page) -> :relation
        #
        expect(Product).to receive(:order).with(:name) do
          double.tap { |a| expect(a).to receive(:page).with(:page).and_return(:relation) }
        end
      end

      before { expect(ProductSearcher).to receive(:search).with(:relation, params).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 12) }

      before { expect(Product).to receive(:find).with(12).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  it_behaves_like :index, skip_authenticate: true

  it_behaves_like :index, skip_authenticate: true, params: { category_id: 1 }

  it_behaves_like :show, format: :pdf do
    let(:options) { WickedPdf.config.merge basic_auth: nil }

    before { expect(subject).to receive(:make_and_send_pdf).with('show', options) }
  end
end
