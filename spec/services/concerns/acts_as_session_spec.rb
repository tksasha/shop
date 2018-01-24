require 'rails_helper'

RSpec.describe ActsAsSession do
  let(:described_class) do
    Class.new do
      include ActsAsSession

      def user; end
    end
  end

  it { should be_an ActiveModel::Model }

  it { should delegate_method(:as_json).to(:auth_token) }

  it { expect(subject.method(:save).original_name).to eq(:valid?) }

  its(:persisted?) { should eq false }

  describe '#auth_token' do
    context do
      before { subject.instance_variable_set :@auth_token, :auth_token }

      its(:auth_token) { should eq :auth_token }
    end

    context do
      before { expect(subject).to receive(:user).and_return(nil) }

      its(:auth_token) { should be_nil }
    end

    context do
      before { expect(subject).to receive_message_chain(:user, :auth_tokens, :create!).and_return(:auth_token) }

      its(:auth_token) { should eq :auth_token }
    end
  end
end
