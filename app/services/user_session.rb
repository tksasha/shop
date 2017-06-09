class UserSession
  include ActiveModel::Model

  validate :user_must_exist, :password_must_pass_authentication

  delegate :id, to: :user, prefix: true

  attr_reader :id, :email, :password

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]
  end

  def save
    @persisted = valid?
  end

  def persisted?
    !!@persisted
  end

  def destroy
    @destroyed = true
  end

  def destroyed?
    !!@destroyed
  end

  def user_blocked?
    user&.blocked
  end

  private
  def user
    @user ||= User.find_by email: @email
  end

  def user_must_exist
    errors.add :email, I18n.t('user_session.error.validation') unless user.present?
  end

  def password_must_pass_authentication
    errors.add :password, I18n.t('user_session.error.validation') unless user.present? && user.authenticate(@password)
  end
end
