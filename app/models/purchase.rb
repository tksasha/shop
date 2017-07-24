class Purchase < ApplicationRecord
  belongs_to :user, optional: false

  belongs_to :product, optional: false

  belongs_to :order, counter_cache: true, optional: true

  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :cart, -> { where order_id: nil }
end
