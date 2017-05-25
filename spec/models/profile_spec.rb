require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should_not allow_value('one@').for(:email) }

  it { should_not allow_value('one@digits').for(:email) }

  it { should allow_value('one@digits.com').for(:email) }

  it { should have_secure_password }
end
