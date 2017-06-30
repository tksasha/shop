class Session
  include ActiveModel::Model

  validate :user_must_exist, :password_must_pass_authentication, :auth_token_must_be_present

  attr_reader :id, :email, :password, :auth_token

  def initialize params = {}
    @email = params[:email]

    @password = params[:password]

    @auth_token = params[:auth_token]
  end

  def save
    @persisted = valid?
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

  def user_blocked?
    !!user&.decorate.blocked?
  end

  private
  def user
    @user ||= UserDecorator.find_by email: @email
  end

  def user_must_exist
    errors.add :email, I18n.t('session.error.validation') unless user.present?
  end

  def password_must_pass_authentication
    errors.add :password, I18n.t('session.error.validation') unless user.present? && user.authenticate(@password)
  end

  def auth_token_must_be_present
    if user.present? && !errors.has_key?(:password)
      token = user.auth_tokens.build(value: SecureRandom.uuid)

      if token.save
        @auth_token = token.value
      else
        errors.add :auth_token, I18n.t('errors.messages.blank')
      end
    end
  end
end
