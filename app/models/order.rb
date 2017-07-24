class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: false

  has_many :purchases

  aasm do
    state :created, initial: true
  end
end
