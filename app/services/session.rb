class Session
  include ActiveModel::Model

  validate :user_must_exist,
           :user_must_not_be_blocked,
           :user_must_be_confirmed,
           :password_must_pass_authentication

  attr_accessor :id, :email, :password

  validates :email, :password, presence: true

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]

    @auth_token = params[:auth_token]
  end

  def save
    return false unless valid?

    @persisted = !!create_auth_token&.persisted?
  end

  def persisted?
    !!@persisted
  end

  def destroy
    token = AuthToken.find_by value: @auth_token

    @destroyed = token ? token.destroy : true
  end

  def destroyed?
    !!@destroyed
  end

  def auth_token
    @auth_token ||= SecureRandom.uuid
  end

  private
  def user
    @user ||= User.find_by email: @email if @email.present?
  end

  def user_must_exist
    return if @email.blank?

    errors.add :email, I18n.t('session.error.email.invalid') if user.blank?
  end

  def user_must_not_be_blocked
    return if user.blank?

    errors.add :email, I18n.t('session.error.email.blocked') if user.decorate.blocked?
  end

  def user_must_be_confirmed
    return if user.blank?

    errors.add :email, I18n.t('session.error.email.not_confirmed') unless user.confirmed?
  end

  def password_must_pass_authentication
    return if user.blank?

    return if @password.blank?

    errors.add :password, I18n.t('session.error.password.invalid') unless user.authenticate @password
  end

  def create_auth_token
    return if user.blank?

    user.auth_tokens.create value: auth_token
  end
end
