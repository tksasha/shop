require 'rails_helper'

RSpec.describe Version, type: :model do
  it { should delegate_method(:as_json).to(:decorate) }
end
