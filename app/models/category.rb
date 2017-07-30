class Category < ApplicationRecord
  include PgSearch

  has_and_belongs_to_many :products
  
  validates :name, presence: true
  
  validates :name, uniqueness: true

  pg_search_scope :search_by_name, against: :name, using: :trigram
end
