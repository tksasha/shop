class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: %i(new create)

  def create
    render :errors, status: 422 unless resource.save
  end

  def destroy
    resource.destroy

    head 204
  end

  private
  def resource
    @resource ||= AuthToken.find auth_token
  end

  def resource_params
    params.require(:session).permit(:email, :password)
  end

  def build_resource
    @resource = Session.new resource_params
  end

  def policy *args
    SessionPolicy.new current_user, nil
  end
end
