RSpec.shared_examples :login_user do
  describe '#login_user' do
    let (:resource) { double }

    before { allow(subject).to receive(:resource).and_return(resource) }

    context do
      before { expect(resource).to receive(:new_record?).and_return(false) }

      before { expect(resource).to receive(:id).and_return(1) }

      after { expect(subject.session[:user_id]).to eq 1 }

      its(:login_user) { should eq 1 }
    end

    context do
      before { expect(resource).to receive(:new_record?).and_return(true) }

      after { expect(subject.session[:user_id]).to eq nil }

      its(:login_user) { should eq nil }
    end
  end
end