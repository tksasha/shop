class UsersController < ApplicationController
  private
  def resource_params
    params.require(:user).permit(:roles)
  end

  def update_success_callback
    redirect_to :users
  end

  def build_resource
    @resource = UserFactory.build resource_params
  end
end
