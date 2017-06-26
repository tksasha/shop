class UsersController < ApplicationController
  include Rest

  include Authorization

  private
  def resource_params
    params.require(:user).permit(:roles)
  end

  def update_success_callback
    redirect_to :users
  end
end
