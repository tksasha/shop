require 'rails_helper'

RSpec.describe OrderFactory do
  let(:user) { double }

  subject { described_class.new user }

  describe '#params' do
    let(:params) { { purchases: :purchases_in_cart, user: user, total: 1 } }

    before do
      expect(user).to receive(:purchases) do
        double.tap { |a| expect(a).to receive(:cart).and_return(params[:purchases]) }
      end
    end

    before { expect(subject).to receive(:total).and_return(params[:total]) }

    its(:params) { should eq params }
  end

  describe '#total' do
    let(:purchases_in_cart) { double }

    before do
      expect(user).to receive(:purchases) do
        double.tap { |a| expect(a).to receive(:cart).and_return(purchases_in_cart) }
      end
    end

    before { expect(purchases_in_cart).to receive(:sum).with(:price).and_return(1) }

    its(:total) { should eq 1 }
  end
end
