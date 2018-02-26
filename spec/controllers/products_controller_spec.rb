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

  describe '#resource_params' do
    let(:params) do
      acp product: {
        name: 'Fantastic Cotton Clock', image: '', price: 24.42, description: 'Description', amount: 11,
        discount_price: nil, currency: :usd, category_ids: [1, 3, 12]
      }
    end

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:product].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:params) }

    before { expect(Product).to receive(:new).with(:params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  it_behaves_like :index, anonymous: true

  it_behaves_like :index, anonymous: true, params: { category_id: 1 }

  it_behaves_like :show, format: :pdf do
    let(:options) { WickedPdf.config.merge basic_auth: nil }

    before { expect(subject).to receive(:make_and_send_pdf).with('show', options) }
  end

  it_behaves_like :create do
    let(:resource) { double }

    let(:success) { -> { should render_template(:create).with_status(201) } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end
end
