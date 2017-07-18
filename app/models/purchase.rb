class Purchase < ApplicationRecord
  belongs_to :user

  validates :user, presence: true

  belongs_to :product

  validates :product, presence: true

  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validates :price, presence: true, numericality: { greater_than: 0 }
end
