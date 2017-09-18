require 'spec_helper'

RSpec.describe Converter do
  describe '#convert' do
    context do
      subject { described_class.new to: :usd, from: :usd }

      it { expect(subject.convert(1).to_d).to eq 1 }
    end

    context do
      subject { described_class.new to: :eur, from: :usd }

      before { expect(subject).to receive(:rate).and_return 1.559 }

      it { expect(subject.convert(1).to_d).to eq 1.56 }
    end
  end

  describe '#pair' do
    context do
      subject { described_class.new to: :uah, from: :eur }

      its(:pair) { should eq 'EUR_UAH' }
    end
  end

  describe '#rate' do
    context do
      subject { described_class.new to: :usd, from: :usd }

      its(:rate) { should eq 1 }
    end

    context do
      subject { described_class.new to: :eur, from: :usd }

      context do
        before { expect(subject).to receive(:redis_rate).and_return 1.5 }

        its(:rate) { should eq 1.5 }
      end

      context do
        before { expect(subject).to receive(:redis_rate).and_return nil }

        before { expect(subject).to receive(:api_rate).and_return 2 }

        before { expect(subject).to receive(:redis_rate=).with(2).and_return 2 }

        its(:rate) { should eq 2 }
      end
    end
  end

  subject { described_class.new to: :eur, from: :usd }

  describe '#redis_rate' do
    let(:redis) { double }

    before { expect(subject).to receive(:redis).and_return redis }

    before { expect(subject).to receive(:pair).and_return 'PAIR' }

    context do
      before { expect(redis).to receive(:get).with('currency:PAIR').and_return nil }

      its(:redis_rate) { should be_nil }
    end

    context do
      before { expect(redis).to receive(:get).with('currency:PAIR').and_return '1.5' }

      its(:redis_rate) { should eq 1.5 }
    end
  end

  describe '#redis_rate=' do
    let(:redis) { double }

    before { expect(subject).to receive(:redis).and_return redis }

    before { expect(subject).to receive(:pair).and_return 'PAIR' }

    before { expect(redis).to receive(:setex).with('currency:PAIR', 1.hour.to_i, 1.5) }

    it { expect { subject.send :redis_rate=, 1.5 }.to_not raise_error }
  end

  describe '#api_rate' do
    let(:request) { double }

    before { expect(subject).to receive(:pair).and_return('PAIR').twice }

    before do
      expect(subject).
        to receive(:open).
        with('http://free.currencyconverterapi.com/api/v3/convert?q=PAIR&compact=ultra').
        and_yield request
    end

    before { expect(request).to receive(:read).and_return('{ "PAIR": 1.5 }') }

    its(:api_rate) { should eq 1.5 }
  end
end
