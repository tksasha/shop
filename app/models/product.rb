class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
