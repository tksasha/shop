RSpec.shared_examples :new do
  describe '#new' do
    before { expect(subject).to receive(:initialize_resource) }

    before { get :new }

    it { should render_template :new }
  end
end

RSpec.shared_examples :create do
  describe '#create' do
    before { expect(subject).to receive(:build_resource) }

    before { allow(subject).to receive(:resource).and_return(resource) }

    before { post :create }

    context do
      before { expect(resource).to receive(:save).and_return(true) }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:save).and_return(false) }

      it { failure.call }
    end
  end
end
