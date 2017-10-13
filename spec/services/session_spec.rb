require 'rails_helper'

RSpec.describe Session, type: :model do
  subject { described_class.new email: 'one@digits.com', password: 'password' }

  it { should validate_presence_of :email }

  it { should validate_presence_of :password }

  describe '#user' do
    before { expect(User).to receive(:find_by).with(email: 'one@digits.com').and_return(:user) }

    its(:user) { should eq :user }
  end

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return false }

      before { expect(subject).to_not receive :create_auth_token }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      context do
        before { expect(subject).to receive(:create_auth_token).and_return nil }

        its(:save) { should eq false }
      end

      context do
        before do
          #
          # subject.create_auth_token.persisted? -> false
          #
          expect(subject).to receive(:create_auth_token) do
            double.tap { |a| expect(a).to receive(:persisted?).and_return false }
          end
        end

        its(:save) { should eq false }
      end

      context do
        before do
          #
          # subject.create_auth_token.persisted? -> true
          #
          expect(subject).to receive(:create_auth_token) do
            double.tap { |a| expect(a).to receive(:persisted?).and_return true }
          end
        end

        its(:save) { should eq true }
      end
    end
  end

  describe '#persisted?' do
    context do
      before { subject.instance_variable_set :@persisted, true }

      its(:persisted?) { should eq true }
    end

    context do
      before { subject.instance_variable_set :@persisted, false }

      its(:persisted?) { should eq false }
    end

    context do
      before { subject.instance_variable_set :@persisted, nil }

      its(:persisted?) { should eq false }
    end
  end

  describe '#destroy' do
    it { expect { subject.destroy }.to_not raise_error }
  end

  describe '#destroyed?' do
    context do
      before { subject.instance_variable_set :@destroyed, true }

      its(:destroyed?) { should eq true }
    end

    context do
      before { subject.instance_variable_set :@destroyed, false }

      its(:destroyed?) { should eq false }
    end

    context do
      before { subject.instance_variable_set :@destroyed, nil }

      its(:destroyed?) { should eq false }
    end
  end

  describe '#user_must_exist' do
    context do
      subject { described_class.new }

      it { expect { subject.send :user_must_exist }.to_not change { subject.errors[:email] } }
    end

    context do
      let(:user) { nil }

      before { expect(subject).to receive(:user).and_return user }

      it do
        expect { subject.send :user_must_exist }
          .to change { subject.errors[:email] }
          .by [I18n.t('session.error.email.invalid')]
      end
    end

    context do
      let(:user) { double }

      before { expect(subject).to receive(:user).and_return user }

      it { expect { subject.send :user_must_exist }.to_not change { subject.errors[:email] } }
    end
  end

  describe '#user_must_not_be_blocked' do
    before { allow(subject).to receive(:user).and_return user }

    context do
      let(:user) { nil }

      it { expect { subject.send :user_must_not_be_blocked }.to_not change { subject.errors[:email] } }
    end

    context do
      context do
        let(:user) { stub_model User, blocked_at: DateTime.now }

        it do
          expect { subject.send :user_must_not_be_blocked }
            .to change { subject.errors[:email] }
            .by [I18n.t('session.error.email.blocked')]
        end
      end

      context do
        let(:user) { stub_model User, blocked_at: nil }

        it { expect { subject.send :user_must_not_be_blocked }.to_not change { subject.errors[:email] } }
      end
    end
  end

  describe '#user_must_be_confirmed' do
    before { allow(subject).to receive(:user).and_return user }

    context do
      let(:user) { nil }

      it { expect { subject.send :user_must_be_confirmed }.to_not change { subject.errors[:email] } }
    end

    context do
      context do
        let(:user) { stub_model User, confirmed: false }

        it do
          expect { subject.send :user_must_be_confirmed }
            .to change { subject.errors[:email] }
            .by [I18n.t('session.error.email.not_confirmed')]
        end
      end

      context do
        let(:user) { stub_model User, confirmed: true }

        it { expect { subject.send :user_must_be_confirmed }.to_not change { subject.errors[:email] } }
      end
    end
  end

  describe '#password_must_pass_authentication' do
    context do
      subject { described_class.new }

      it { expect { subject.send :password_must_pass_authentication }.to_not change { subject.errors[:password] } }
    end

    context do
      let(:user) { nil }

      before { expect(subject).to receive(:user).and_return user }

      it { expect { subject.send :password_must_pass_authentication }.to_not change { subject.errors[:password] } }
    end

    context do
      let(:user) { double }

      before { expect(subject).to receive(:user).and_return(user).twice }

      context do
        before { expect(user).to receive(:authenticate).with('password').and_return false }

        it do
          expect { subject.send :password_must_pass_authentication }
            .to change { subject.errors[:password] }
            .by [I18n.t('session.error.password.invalid')]
        end
      end

      context do
        before { expect(user).to receive(:authenticate).with('password').and_return true }

        it { expect { subject.send :password_must_pass_authentication }.to_not change { subject.errors[:password] } }
      end
    end
  end

  describe '#create_auth_token' do
    context do
      let(:user) { double }

      before { expect(subject).to receive(:auth_token).and_return :auth_token }

      before { expect(subject).to receive(:user).and_return(user).twice }

      before do
        #
        # user.auth_tokens.create value: :auth_token -> :create_auth_token
        #
        expect(user).to receive(:auth_tokens) do
          double.tap do |a|
            expect(a).to receive(:create).with(value: :auth_token).and_return :create_auth_token
          end
        end
      end

      its(:create_auth_token) { should eq :create_auth_token }
    end

    context do
      before { expect(subject).to receive(:user).and_return nil }

      its(:create_auth_token) { should be_nil }
    end
  end
end
