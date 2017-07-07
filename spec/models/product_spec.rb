require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_and_belong_to_many :categories }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should act_as_paranoid }

  it { should have_attached_file :image }

  it { should validate_presence_of :name }

  # TODO:
  # preserve_files: true
  # content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  # size: { in: 0..5.megabytes }
end
