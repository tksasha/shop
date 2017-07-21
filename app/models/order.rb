class Order < ApplicationRecord
  include AASM

  aasm do
    state :created, initial: true
  end

  has_many :purchases
end
