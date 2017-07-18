require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { should belong_to :user }

  it { should belong_to :product }

  it { should validate_presence_of :user }

  it { should validate_presence_of :product }

  it { should validate_presence_of :amount }

  it { should validate_presence_of :price }

  it { should validate_numericality_of(:amount).is_greater_than(0).only_integer }

  it { should validate_numericality_of(:price).is_greater_than(0) }
end