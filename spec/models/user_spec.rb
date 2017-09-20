require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }

  it { should have_many :auth_tokens }

  it { should have_many :orders }

  it { should have_many :purchases }

  it { should validate_presence_of :email }

  it { should define_enum_for(:currency).with(Currency::ALLOWED) }

  context do
    before { allow(subject).to receive(:send_confirmation_email) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  it { should_not allow_value('one@').for(:email) }

  it { should_not allow_value('one@digits').for(:email) }

  it { should allow_value('one@digits.com').for(:email) }

  it { should validate_presence_of :roles }

  it { should callback(:send_confirmation_email).after(:commit).on(:create) }

  describe '#send_confirmation_email' do
    subject { UserFactory.build email: 'to@example.com', password_digest: 'password_digest' }

    before do
      #
      # ConfirmationMailer.email(self).deliver_later
      #
      expect(ConfirmationMailer).to receive(:email).with(subject) do
        double.tap { |a| expect(a).to receive(:deliver_later) }
      end
    end

    it { expect { subject.send(:send_confirmation_email) }.to_not raise_error }
  end
end
