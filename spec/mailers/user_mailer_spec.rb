require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  describe '#email' do
    let(:user) { double }

    let(:subject) { described_class.email user } 

    before { allow(user).to receive(:persisted?).and_return(true) }

    before { allow(user).to receive(:confirmation_token).and_return('confirmation_token') }

    before { allow(user).to receive(:email).and_return('email') }

    its(:subject) { should eq 'Confirmation' }

    its(:from) { should eq ['from@example.com'] } 

    its(:to) { should eq ['email'] }
  end
end
