require 'rails_helper'

RSpec.describe ProductDecorator do
  subject { described_class.new stub_model Product, price: 2.1 }

  describe '#current_user' do
    it { should delegate_method(:current_user).to :h }
  end

  describe '#converter' do
    before do
      #
      # subject.current_user.currency -> :uah
      #
      expect(subject).to receive(:current_user) do
        double.tap { |a| expect(a).to receive(:currency).and_return :uah }
      end
    end

    its(:converter) { should be_a Converter }

    its('converter.to') { should eq :uah }

    its('converter.from') { should eq :usd }
  end

  describe '#price' do
    before do
      #
      # subject.converter.convert -> :price
      #
      expect(subject).to receive(:converter) do
        double.tap { |a| expect(a).to receive(:convert).with(2.1).and_return :price }
      end
    end

    its(:price) { should eq :price }
  end
end
