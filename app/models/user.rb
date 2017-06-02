class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  bitmask :roles, :as => [:user, :admin]

  validates :roles, presence: true

  has_secure_password
end
