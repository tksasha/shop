class Category < ApplicationRecord
  include PgSearch

  has_and_belongs_to_many :products

  has_attached_file :image, preserve_files: true, styles: { '500x500': '500x500#' }

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validates_attachment :image, presence: true,
    content_type: { content_type: ['image/jpeg', 'image/gif', 'image/png'] },
    file_name: { matches: [/jpe?g\z/, /gif\z/, /png\z/] },
    size: { in: 0..5.megabytes }

  pg_search_scope :search_by_name, against: :name, using: :trigram

  before_save :assign_slug, if: :assign_slug?

  def to_param
    slug
  end

  private
  def assign_slug
    self.slug = name.parameterize
  end

  def assign_slug?
    name.present? && name_changed?
  end
end
