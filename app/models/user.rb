class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true

  bitmask :roles, as: [:user, :admin]

  validates :roles, presence: true

  validates :confirmation_token, presence: true

  has_secure_password

  has_many :auth_tokens

  after_commit :send_confirmation_email, on: :create

  private
  def send_confirmation_email
    ConfirmationMailer.email(self).deliver_now
  end
end
