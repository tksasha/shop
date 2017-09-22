require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should have_and_belong_to_many :products }
  
  it { should validate_presence_of :name }
  
  it { should validate_uniqueness_of :name }

  it { should have_attached_file :image }

  it { should validate_attachment_presence :image }

  it { should validate_attachment_content_type(:image).allowing('image/gif', 'image/jpeg', 'image/png') }

  it { should validate_attachment_size(:image).in(0..5.megabytes) }
end
