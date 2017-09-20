require 'rails_helper'

RSpec.describe Currency do
  subject { described_class.new name: :uah, value: 21.05 }

  it { should eq '21.05 UAH' }

  its(:to_d) { should eq 21.05 }

  describe '#name' do
    subject { described_class.new name: 'uah', value: 10.52 }

    its(:name) { should eq :uah }
  end

  describe '#value' do
    its(:value) { should eq 21.05 }

    context do
      subject { described_class.new name: :uah, value: 10.5452 }

      its(:value) { should eq 10.55 }
    end
  end

  describe '#to_s' do
    its(:to_s) { should eq '21.05 UAH' }

    context do
      subject { described_class.new name: :usd, value: 10 }

      its(:to_s) { should eq '$10.00' }
    end

    context do
      subject { described_class.new name: :eur, value: 11 }

      its(:to_s) { should eq '€11.00' }
    end
  end
end
