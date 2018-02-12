module ActsAsAuthenticatedController
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    before_action :authenticate!
  end

  private
  def current_user
    return if auth_token.blank?

    @current_user ||= User.joins(:auth_tokens).where(auth_tokens: { id: auth_token }).first
  end

  def auth_token
    authenticate_with_http_token do |token, options|
      @auth_token = token
    end if @auth_token.blank?

    @auth_token
  end

  def authenticate!
    head :unauthorized unless current_user
  end
end
