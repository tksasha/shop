RSpec.shared_examples :new do |params|
  before { @skip_authenticate = (params && params[:skip_authenticate]) || false }

  describe '#new' do
    before { expect(subject).to receive(:authenticate!) unless @skip_authenticate }

    before { expect(subject).to receive(:initialize_resource) }

    before { expect(subject).to receive(:resource).and_return(:resource) }

    before { expect(subject).to receive(:authorize).with(:resource).and_return(true) }

    before { get :new }

    it { should render_template :new }
  end
end

RSpec.shared_examples :show do |params|
  before { @skip_authenticate = (params && params[:skip_authenticate]) || false }

  describe '#show' do
    before { expect(subject).to receive(:authenticate!) unless @skip_authenticate }

    before { expect(subject).to receive(:resource).and_return(:resource) }

    before { expect(subject).to receive(:authorize).with(:resource).and_return(true) }
    
    before { get :show, params: { id: 1 } }

    it { should render_template :show }
  end
end

RSpec.shared_examples :create do |params|
  before { @params = (params && params[:params]) || {} }

  before { @format = (params && params[:format]) || :html }

  before { @skip_authenticate = (params && params[:skip_authenticate]) || false }

  describe '#create' do
    before { expect(subject).to receive(:authenticate!) unless @skip_authenticate }

    before { expect(subject).to receive(:build_resource) }

    before { allow(subject).to receive(:resource).and_return(resource) }

    before { expect(subject).to receive(:authorize).with(resource).and_return(true) }

    context do
      before { expect(resource).to receive(:save).and_return(true) }

      before { post :create, params: @params, format: @format }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:save).and_return(false) }

      before { post :create, params: @params, format: @format }

      it { failure.call }
    end
  end
end

RSpec.shared_examples :edit do |params|
  before { @skip_authenticate = (params && params[:skip_authenticate]) || false }

  describe '#edit' do
    before { expect(subject).to receive(:authenticate!) unless @skip_authenticate }

    before { expect(subject).to receive(:resource).and_return(:resource) }

    before { expect(subject).to receive(:authorize).with(:resource).and_return(true) }

    before { get :edit, params: { id: 1 } }

    it { should render_template :edit }
  end
end

RSpec.shared_examples :update do |params|
  before { @skip_authenticate = (params && params[:skip_authenticate]) || false }

  describe '#update' do
    before { expect(subject).to receive(:authenticate!) unless @skip_authenticate }

    before { allow(subject).to receive(:resource).and_return(resource) }

    before { expect(subject).to receive(:authorize).with(resource).and_return(true) }

    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    context do
      before { expect(resource).to receive(:update).with(:resource_params).and_return(true) }

      before { patch :update, params: { id: 1 } }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:update).with(:resource_params).and_return(false) }

      before { patch :update, params: { id: 1 } }

      it { failure.call }
    end
  end
end

RSpec.shared_examples :index do |params|
  before { @skip_authenticate = (params && params[:skip_authenticate]) || false }

  describe '#index' do
    before { expect(subject).to receive(:authenticate!) unless @skip_authenticate }

    before { expect(subject).to receive(:collection).and_return(:collection) }

    before { expect(subject).to receive(:authorize).with(:collection).and_return(true) }

    before { get :index }

    it { should render_template :index }
  end
end

RSpec.shared_examples :destroy do |params|
  before { @format = (params && params[:format]) || :html }

  before { @params = (params && params[:params]) || { id: 1 } }

  before { @skip_authenticate = (params && params[:skip_authenticate]) || false }

  describe '#destroy' do
    let(:resource) { double }

    before { expect(subject).to receive(:authenticate!) unless @skip_authenticate }

    before { subject.instance_variable_set :@resource, resource }

    before { expect(subject).to receive(:authorize).with(resource).and_return(true) }

    before { expect(resource).to receive(:destroy) }

    before { delete :destroy, params: @params, format: @format }

    it { success.call }
  end
end
