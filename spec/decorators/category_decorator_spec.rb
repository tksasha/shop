require 'rails_helper'

RSpec.describe CategoryDecorator do
  let(:category) { stub_model Category, id: 28, name: 'Food and Drinks', slug: 'food-and-drinks' }

  subject { category.decorate }

  describe '#as_json' do
    before { expect(subject).to receive(:image_url).and_return(:url) }

    its(:as_json) { should eq id: 'food-and-drinks', name: 'Food and Drinks', image: :url }
  end

  describe '#image_url' do
    before { expect(subject).to receive_message_chain(:image, :url).with(:'500x500').and_return('/images/1.png') }

    its(:image_url) { should eq 'http://test.host/images/1.png' }
  end
end
