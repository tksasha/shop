RSpec.shared_examples :new do
  describe '#new' do
    before { expect(subject).to receive(:initialize_resource) }

    before { expect(subject).to receive(:authorize_resource) }

    before { get :new }

    it { should render_template :new }
  end
end

RSpec.shared_examples :show do
  describe '#show' do
    before { expect(subject).to receive(:authorize_resource) }
    
    before { get :show, params: { id: 1 } }

    it { should render_template :show }
  end
end


RSpec.shared_examples :create do
  describe '#create' do

    before { expect(subject).to receive(:build_resource) }

    before { allow(subject).to receive(:resource).and_return(resource) }

    before { expect(subject).to receive(:authorize_resource) }

    context do
      before { expect(resource).to receive(:save).and_return(true) }

      before { post :create, params: {} }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:save).and_return(false) }

      before { post :create, params: {} }

      it { failure.call }
    end
  end
end
