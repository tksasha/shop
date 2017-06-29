class SessionsController < ApplicationController
  include Rest

  include Authorization

  skip_before_action :authenticate!, only: [:new, :create]

  after_action :login_user, only: :create

  after_action :logout_user, only: :destroy

  private
  def resource
    @resource ||= Session.new auth_token: auth_token
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end

  def login_user
    session[:auth_token] = resource.auth_token if resource.persisted?
  end

  def logout_user
    session[:auth_token] = nil if resource.destroyed?
  end

  def create_success_callback
    respond_to do |format|
      format.html { redirect_to :profile }

      format.json { render }
    end
  end

  def destroy_callback
    respond_to do |format|
      format.html { redirect_to [:new, :session] }

      format.json { head :no_content }
    end
  end
end
