require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  it_behaves_like :index, format: :json, skip_authenticate: true

  it_behaves_like :index, format: :json, skip_authenticate: true, params: { category_id: 1 }

  it_behaves_like :show, format: :pdf do
    let(:options) { WickedPdf.config.merge basic_auth: nil }

    before { expect(subject).to receive(:make_and_send_pdf).with('show', options) }
  end
end
