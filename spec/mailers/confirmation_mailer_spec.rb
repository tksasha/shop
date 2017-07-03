require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  describe '#email' do
    let(:user) { stub_model User, email: 'email', confirmation_token: 'confirmation_token' }

    let(:subject) { described_class.email user }

    its(:subject) { should eq 'Confirmation' }

    its(:from) { should eq ['from@example.com'] }

    its(:to) { should eq ['email'] }
  end
end
