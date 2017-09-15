require 'rails_helper'

RSpec.describe UpdateSimilaritiesJob, type: :job do
  let(:one) { stub_model Product }

  let(:two) { stub_model Product }

  let(:order) { stub_model Order }

  before { expect(order).to receive(:products).and_return([one, two]) }

  before { expect(Similarities).to receive(:update!).with(one, order) }

  before { expect(Similarities).to receive(:update!).with(two, order) }

  it { expect { subject.perform order }.to_not raise_error }
end
