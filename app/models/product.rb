class Product < ApplicationRecord
  include PgSearch

  acts_as_paranoid

  has_and_belongs_to_many :categories

  has_attached_file :image, preserve_files: true, styles: { '500x500': '500x500#' }

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validates :price, presence: true, numericality: { greater_than: 0 }

  validates :discount_price, allow_nil: true, numericality: { greater_than: 0 }

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

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

  scope :present, -> { where 'amount > 0' }

  enum currency: Currency::ALLOWED
end
