require 'rails_helper'

RSpec.describe Currency do
  subject { described_class.new 21.05.to_d, :uah }

  describe 'as a string' do
    it { should eq '21.05 UAH' }
  end

  describe '#to_s' do
    its(:to_s) { should eq '21.05 UAH' }
  end

  describe '#to_d' do
    its(:to_d) { should eq 21.05.to_d }
  end
end
