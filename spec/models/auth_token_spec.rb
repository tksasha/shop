require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  it { should delegate_method(:as_json).to(:decorate) }

  it { should belong_to :user }
end
