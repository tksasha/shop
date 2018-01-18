class Session
  include ActiveModel::Model

  delegate :as_json, to: :auth_token, allow_nil: true

  attr_accessor :email, :password

  validates :email, :password, presence: true

  validate :user_must_exist, :password_must_pass_authentication, :user_must_not_be_blocked, :user_must_be_confirmed

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]
  end

  def persisted?
    false
  end

  def auth_token
    @auth_token ||= user&.auth_tokens&.create!
  end

  alias_method :save, :valid?

  private
  def user
    @user ||= User.find_by email: email if email.present?
  end

  def user_must_exist
    return if email.blank?

    errors.add :email, :invalid if user.blank?
  end

  def password_must_pass_authentication
    return if password.blank?

    return if user.blank?

    errors.add :password, :invalid unless user.authenticate password
  end

  def user_must_not_be_blocked
    return if user.blank?

    errors.add :email, I18n.t(:blocked, scope: %i(session error)) if user.decorate.blocked?
  end

  def user_must_be_confirmed
    return if user.blank?

    errors.add :email, I18n.t(:not_confirmed, scope: %i(session error)) unless user.confirmed?
  end
end
