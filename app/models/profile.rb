class Profile < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  has_secure_password
end
