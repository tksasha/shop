class Product < ApplicationRecord
  include PgSearch

  acts_as_paranoid

  has_and_belongs_to_many :categories

  has_attached_file :image, preserve_files: true

  paginates_per 7

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validates :price, presence: true, numericality: { greater_than: 0 }

  validates_attachment :image, presence: true,
    content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
    file_name: { matches: [/jpe?g\z/, /gif\z/, /png\z/] },
    size: { in: 0..5.megabytes }

  pg_search_scope :search_by_description,
    against: :description,
    using: {
      tsearch: {
        dictionary: :english,
        tsvector_column: :description_tsvector
      }
    }

  pg_search_scope :search_by_name, against: :name, using: :trigram
end
