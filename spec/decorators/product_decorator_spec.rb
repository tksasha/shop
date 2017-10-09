require 'rails_helper'

RSpec.describe ProductDecorator do
  subject { described_class.new stub_model Product, price: 2.1, currency: :usd }

  it { should delegate_method(:current_user).to(:h) }

  it { should delegate_method(:current_user_currency).to(:current_user).as(:currency) }

  describe '#current_user_currency' do
    before { expect(subject).to receive(:current_user) }

    its(:current_user_currency) { should be_nil }
  end

  describe '#price' do
    before { expect(subject).to receive(:current_user_currency).and_return(:uah) }

    before { expect(CurrencyConverter).to receive(:convert).with(from: 'usd', to: :uah, sum: 2.1).and_return(54.60) }

    its(:price) { should eq 54.60 }
  end
end
