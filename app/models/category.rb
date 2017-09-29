class Category < ApplicationRecord
  include PgSearch

  has_and_belongs_to_many :products

  has_attached_file :image, preserve_files: true
  
  validates :name, presence: true
  
  validates :name, uniqueness: true

  validates_attachment :image, presence: true,
    content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
    file_name: { matches: [/jpe?g\z/, /gif\z/, /png\z/] },
    size: { in: 0..5.megabytes }

  pg_search_scope :search_by_name, against: :name, using: :trigram
end
