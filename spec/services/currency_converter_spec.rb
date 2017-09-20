require 'spec_helper'

RSpec.describe CurrencyConverter do
  subject { described_class.new from: :usd, to: :uah, sum: 15.40 }

  its(:currencies) { should eq 'USD_UAH' }

  describe '#cached_exchange_rate' do
    context do
      before { expect($redis).to receive(:get).with('currencies_exchange_rate:USD_UAH').and_return('25.52') }

      its(:cached_exchange_rate) { should eq 25.52 }
    end

    context do
      before { expect($redis).to receive(:get).with('currencies_exchange_rate:USD_UAH').and_return(nil) }

      its(:cached_exchange_rate) { should be_nil }
    end
  end

  describe '#cached_exchange_rate=' do
    before { expect($redis).to receive(:setex).with('currencies_exchange_rate:USD_UAH', 1.hour, 25.07) }

    it { expect { subject.cached_exchange_rate = 25.07 }.to_not raise_error }
  end

  describe '#remote_exchange_rate' do
    let(:response) { double read: '{"USD_UAH":25.21}' }

    before do
      expect(subject).to receive(:open).
        with('http://free.currencyconverterapi.com/api/v3/convert?compact=ultra&q=USD_UAH').
        and_return(response)
    end

    its(:remote_exchange_rate) { should eq 25.21 }
  end

  describe '#exchange_rate' do
    context do
      before { subject.cached_exchange_rate = 25.05 }

      its(:exchange_rate) { should eq 25.05 }
    end

    context do
      before { $redis.del 'currencies_exchange_rate:USD_UAH' }

      before { expect(subject).to receive(:remote_exchange_rate).and_return(25.06) }

      before { expect(subject).to receive(:cached_exchange_rate=).with(25.06).and_call_original }

      its(:exchange_rate) { should eq 25.06 }
    end

    context do
      subject { described_class.new from: :uah, to: :uah, sum: 16.52 }

      its(:exchange_rate) { should eq 1 }
    end
  end

  describe '#convert' do
    before { expect(subject).to receive(:exchange_rate).and_return(25.08) }

    its(:convert) { should be_a Currency }

    its(:convert) { should eq '386.23 UAH' }
  end

  describe '.convert' do
    before do
      #
      # described_class.new(from: :usd, to: :uah, sum: 17.03).convert -> 425.75
      #
      expect(described_class).to receive(:new).with(from: :usd, to: :uah, sum: 17.03) do
        double.tap { |a| expect(a).to receive(:convert).and_return(425.75) }
      end
    end

    subject { described_class.convert from: :usd, to: :uah, sum: 17.03 }

    it { should eq 425.75 }
  end
end
