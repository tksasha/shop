class Product < ApplicationRecord
  acts_as_paranoid

  has_and_belongs_to_many :categories

  paginates_per 7

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end