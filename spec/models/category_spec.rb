require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should delegate_method(:as_json).to(:decorate) }

  it { should have_and_belong_to_many :products }

  it { should validate_presence_of :name }

  context do
    subject { described_class.new name: 'a value' }

    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it { should have_attached_file :image }

  it { should validate_attachment_presence :image }

  it { should validate_attachment_content_type(:image).allowing('image/gif', 'image/jpeg', 'image/png') }

  it { should validate_attachment_size(:image).in(0..5.megabytes) }

  it { should callback(:assign_slug).before(:save).if :assign_slug? }

  describe '#assign_slug' do
    subject { described_class.new name: 'Foods and Beverages' }

    it { expect { subject.send :assign_slug }.to change { subject.slug }.from(nil).to 'foods-and-beverages' }
  end

  describe '#assign_slug?' do
    context do
      subject { described_class.new }

      its(:assign_slug?) { should eq false }
    end

    context do
      subject { described_class.new name: 'Foods and Beverages' }

      context do
        before { expect(subject).to receive(:name_changed?).and_return false }

        its(:assign_slug?) { should eq false }
      end

      context do
        before { expect(subject).to receive(:name_changed?).and_return true }

        its(:assign_slug?) { should eq true }
      end
    end
  end

  describe '#to_param' do
    subject { described_class.new slug: 'foods-and-beverages' }

    its(:to_param) { should eq 'foods-and-beverages' }
  end
end
