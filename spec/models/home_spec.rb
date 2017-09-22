require 'rails_helper'

RSpec.describe Home do
  describe '#categories' do
    before { expect(Category).to receive(:order).with(:name).and_return(:collection) }

    its(:categories) { should eq :collection }
  end
end
