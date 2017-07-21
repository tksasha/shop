require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many :purchases }

  it { should have_state :created }
end
