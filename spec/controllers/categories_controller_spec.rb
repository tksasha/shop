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

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    its(:resource) { should be_nil }
  end

  describe '#resource_params' do
    let(:params) { acp category: { name: '', image: '' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:category].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:params) }

    before { expect(Category).to receive(:new).with(:params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  it_behaves_like :index, anonymous: true

  it_behaves_like :create do
    let(:resource) { double }

    let(:success) { -> { should render_template(:create).with_status(201) } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end
end
