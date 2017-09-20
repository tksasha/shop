class User < ApplicationRecord
  bitmask :roles, as: [:user, :admin]

  enum currency: Currency::ALLOWED

  has_secure_password

  has_many :auth_tokens

  has_many :orders

  has_many :purchases

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  validates :roles, presence: true

  after_commit :send_confirmation_email, on: :create

  private
  def send_confirmation_email
    ConfirmationMailer.email(self).deliver_later
  end
end
