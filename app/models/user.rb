class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  bitmask :roles, as: [:user, :admin]

  validates :roles, presence: true

  validates :blocked, inclusion: { in: [true, false] }

  has_secure_password

  has_many :auth_tokens
end
