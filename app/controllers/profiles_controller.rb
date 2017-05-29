class ProfilesController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  after_action :login_user, only: :create

  private
  def login_user
    session[:user_id] = resource.id unless resource.new_record?
  end

  def resource
    @resource ||= current_user
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def resource_model
    User
  end

  def create_success_callback
    redirect_to :profile
  end
end
