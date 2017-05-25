class SessionsController < ApplicationController
  after_action :login_user, only: :create

  def show
    redirect_to current_user
  end

  private
  def resource_params
    params.require(:session).permit(:email, :password)
  end

  def login_user
    session[:user_id] = resource.user_id if resource.persisted?
  end
end
