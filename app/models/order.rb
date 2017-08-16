class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: false

  has_many :purchases

  has_many :products, through: :purchases

  after_commit :perform_update_similarities_job, on: :create

  aasm do
    state :created, initial: true
  end

  private
  def perform_update_similarities_job
    UpdateSimilaritiesJob.perform_later self
  end
end
