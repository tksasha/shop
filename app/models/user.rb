class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  bitmask :roles, as: [:user, :admin]

  validates :roles, presence: true

  has_secure_password

  has_many :auth_tokens

  has_many :purchases

  after_commit :send_confirmation_email, on: :create

  private
  def send_confirmation_email
    ConfirmationMailer.email(self).deliver_later
  end
end
