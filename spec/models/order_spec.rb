require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to :user }

  it { should have_many :purchases }

  it { should have_many(:products).through(:purchases) }

  it { should have_state :created }

  it { should callback(:perform_update_similarities_job).after(:commit).on(:create) }

  describe '#perform_update_similarities_job' do
    before { expect(UpdateSimilaritiesJob).to receive(:perform_later).with(subject) }

    it { expect { subject.send :perform_update_similarities_job }.to_not raise_error }
  end
end
