module ActsAsAuthenticatedController
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    before_action :authenticate!
  end

  private
  def current_user
    return if auth_token.blank?

    @current_user ||= User.joins(:auth_tokens).where(auth_tokens: { value: auth_token }).first
  end

  def auth_token
    respond_to do |format|
      format.html { @auth_token = session[:auth_token] }

      format.js { @auth_token = session[:auth_token] }

      format.json do
        authenticate_with_http_token { |token, options| @auth_token = token }
      end

      format.pdf { @auth_token = session[:auth_token] }
    end unless @auth_token

    @auth_token
  end

  def authenticate!
    respond_to do |format|
      format.html { redirect_to [:new, :session] unless current_user }

      format.json { head :unauthorized unless current_user }

      format.js { head :unauthorized unless current_user }

      format.pdf { head :unauthorized unless current_user }
    end
  end
end
