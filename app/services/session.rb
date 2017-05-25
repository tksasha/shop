class Session
  include ActiveModel::Model

  attr_reader :id

  VALIDATIONS_ERROR_MESSAGE = 'invalid email or password'

  validate :user_must_exist, :password_must_pass_authentication

  delegate :id, to: :user, prefix: true

  def initialize params = nil
    if params.present?
      @email = params[:email]
      @password = params[:password]
    end
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
    @user ||= Profile.find_by email: @email if @email.present?
  end

  def user_must_exist
    errors.add :email, VALIDATIONS_ERROR_MESSAGE unless user.present?
  end

  def password_must_pass_authentication
    errors.add :password, VALIDATIONS_ERROR_MESSAGE unless user.present? && user.authenticate(@password)
  end
end
