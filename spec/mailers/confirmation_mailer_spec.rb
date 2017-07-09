require 'rails_helper'

RSpec.describe ConfirmationMailer, type: :mailer do
  describe '#email' do
    let(:user) { stub_model User, email: 'one@digits.com', confirmation_token: 'XXXX-YYYY-ZZZZ' }

    let(:subject) { described_class.email user }

    its(:subject) { should eq 'Confirmation' }

    its(:from) { should eq ['mail@tksasha.me'] }

    its(:to) { should eq ['one@digits.com'] }
  end
end
