class ProfilesController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  after_action :login_user, only: :create

  private
  def resource_params
    params.require(:profile).permit(:email, :password, :password_confirmation)
  end

  def login_user
    session[:user_id] = resource.id unless resource.new_record?
  end
end
