class ProfilesController < ApplicationController
  skip_before_action :authenticate!, only: [:new, :create]

  private
  def resource
    @resource ||= current_user
  end

  def build_resource
    @resource = UserFactory.build resource_params
  end

  def resource_params
    case action_name
    when 'create'
      params.require(:user).permit(:email, :password, :password_confirmation)
    when 'update'
      params.require(:user).permit(:currency)
    end
  end

  def resource_model
    User
  end

  def create_success_callback
    redirect_to :confirmations
  end

  def update_success_callback
    redirect_to :profile
  end
end
