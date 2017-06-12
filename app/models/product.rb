class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_and_belongs_to_many :categories
  
  paginates_per 10
end
