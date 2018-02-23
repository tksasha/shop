class Confirmation
  include ActiveModel::Validations

  attr_accessor :token

  validates :token, presence: true

  validate :user_must_exist

  def initialize params={}
    @token = params[:token]
  end

  def save
    return false unless valid?

    user.update confirmed: true
  end

  private
  def user
    @user ||= User.find_by confirmation_token: token if token.present?
  end

  def user_must_exist
    return if token.blank?

    errors.add :token, :invalid if user.blank?
  end
end
