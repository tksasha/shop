require 'rails_helper'

describe CategorySearcher do
  let(:relation) { Category.all }

  subject { described_class.new relation }

  describe '#search_by_name' do
    before { expect(relation).to receive(:search_by_name).with(:name).and_return(:result) }

    it { expect(subject.search_by_name :name).to eq(:result) }
  end
end
