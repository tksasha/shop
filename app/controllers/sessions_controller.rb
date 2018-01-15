class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: %i(new create)

  def create
    render :errors, status: 400 unless resource.save
  end

  def destroy
    resource.destroy

    head 204
  end

  private
  def resource
    @resource ||= Session.new auth_token: auth_token
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end

  def build_resource
    @resource = Session.new resource_params
  end
end
