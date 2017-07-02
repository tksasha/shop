require 'rails_helper'

RSpec.describe ConfirmationsController, type: :controller do
  it_behaves_like :show, skip_authenticate: true do
    before { expect(subject).to receive(:resource).and_return(resource) }

    before { expect(resource).to receive(:confirm) }
  end

  it_behaves_like :index, skip_authenticate: true
end
