module Authorization
  include Pundit

  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError do
      respond_to do |format|
        format.html { render 'errors/forbidden', status: :forbidden }

        format.json { head :forbidden }

        format.js { head :forbidden }
      end
    end

    before_action :authenticate_user

    before_action -> { authorize resource }, except: :index

    before_action -> { authorize collection }, only: :index
  end

  private
  def current_user
    @current_user ||= User.joins(:auth_tokens).where(auth_tokens: { value: auth_token }).first
  end

  def auth_token
    respond_to do |format|
      format.html { @token = session[:auth_token] }

      format.js { @token = session[:auth_token] }

      format.json do
        authenticate_with_http_token { |token, options| @token = token }
      end
    end if !@token

    @token
  end

  def authenticate_user
    respond_to do |format|
      format.html { redirect_to [:new, :session] unless current_user }

      format.json { head :unauthorized unless current_user }

      format.js { head :unauthorized unless current_user }
    end
  end
end
