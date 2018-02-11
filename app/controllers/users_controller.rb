class UsersController < ApplicationController
  skip_before_action :authenticate!, only: :create

  wrap_parameters :user, include: %i(email password password_confirmation)

  def create
    render :errors, status: 422 unless resource.save
  end

  private
  attr_reader :resource

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def build_resource
    @resource = UserFactory.build resource_params
  end
end
