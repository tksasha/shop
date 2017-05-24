class Session
  include ActiveModel::Model

  VALIDATIONS_ERROR_MESSAGE = 'invalid email or password'

  validate :user_must_exist, :password_must_pass_authentication

  delegate :id, to: :user, prefix: true

  def initialize params
    @email = params[:email]

    @password = params[:password]
  end

  def save
    @persisted = valid?
  end

  def persisted?
    !!@persisted
  end

  def destroy; end

  private
  def user
    @user ||= User.find_by email: @email
  end

  def user_must_exist
    errors.add :email, VALIDATIONS_ERROR_MESSAGE unless user.present?
  end

  def password_must_pass_authentication
    errors.add :password, VALIDATIONS_ERROR_MESSAGE unless user.present? && user.authenticate(@password)
  end
end
