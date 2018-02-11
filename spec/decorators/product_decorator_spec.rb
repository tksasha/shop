require 'rails_helper'

RSpec.describe ProductDecorator do
  let(:product) do
    stub_model Product,
      id: 22,
      name: 'Food',
      description: 'A description of product',
      amount: 5,
      price: 2.1,
      discount_price: 1.1,
      currency: :usd
  end

  subject { product.decorate }

  it { should delegate_method(:current_user).to(:h) }

  it { should delegate_method(:current_user_currency).to(:current_user).as(:currency) }

  describe '#as_json' do
    before { expect(subject).to receive(:image_url).and_return(:url) }

    before { expect(subject).to receive(:price).and_return(24.99) }

    before { expect(subject).to receive(:discount_price).and_return(12.99) }

    its(:as_json) do
      should eq id: 22,
        name: 'Food',
        description: 'A description of product',
        image: :url,
        amount: 5,
        price: 24.99,
        discount_price: 12.99
    end
  end

  describe '#image_url' do
    before { expect(subject).to receive_message_chain(:image, :url).and_return('/images/1.png') }

    its(:image_url) { should eq 'http://test.host/images/1.png' }
  end

  describe '#current_user_currency' do
    before { expect(subject).to receive(:current_user) }

    its(:current_user_currency) { should be_nil }
  end

  describe '#price' do
    before { expect(subject).to receive(:convert_currency).with(2.1).and_return(54.60) }

    its(:price) { should eq 54.60 }
  end

  describe '#discount_price' do
    context do
      before { expect(subject).to receive(:convert_currency).with(1.1).and_return(54.60) }

      its(:discount_price) { should eq 54.60 }
    end

    context do
      subject { described_class.new stub_model Product, price: 2.1, discount_price: nil, currency: :usd }

      before { expect(subject).to_not receive(:convert_currency) }

      its(:discount_price) { should be_nil }
    end
  end

  describe '#convert_currency' do
    before { expect(subject).to receive(:current_user_currency).and_return(:uah) }

    before { expect(CurrencyConverter).to receive(:convert).with(from: 'usd', to: :uah, sum: 10).and_return(54.60) }

    it { expect(subject.send :convert_currency, 10).to eq 54.60 }
  end
end
