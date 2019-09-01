class User < ApplicationRecord
  delegate :as_json, to: :decorate

  bitmask :roles, as: [:user, :admin]

  enum currency: Currency::ALLOWED

  has_secure_password validations: false

  has_many :auth_tokens, dependent: :destroy

  has_many :orders

  has_many :purchases

  with_options if: :email_user? do
    validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED

    validates_confirmation_of :password, allow_blank: true

    validates :email, presence: true

    after_commit :send_confirmation_email, on: :create

    validate do |record|
      record.errors.add(:password, :blank) unless record.password_digest.present?
    end
  end

  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEXP }, allow_nil: true

  validates :roles, presence: true

  private
  def send_confirmation_email
    ConfirmationMailer.email(self).deliver_later
  end

  def email_user?
    facebook_id.blank?
  end
end
