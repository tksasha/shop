class Product < ApplicationRecord
  acts_as_paranoid

  has_and_belongs_to_many :categories

  has_attached_file :image, preserve_files: true

  paginates_per 7

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
    size: { in: 0..5.megabytes }
end