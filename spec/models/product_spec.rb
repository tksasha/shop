require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_and_belong_to_many :categories }
  
  it { should validate_presence_of :name }
  
  it { should validate_uniqueness_of :name }
end
