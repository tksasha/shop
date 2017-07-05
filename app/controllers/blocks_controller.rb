class BlocksController < ApplicationController
  private
  def resource_params
    params[:user_id]
  end

  def resource
    @resource ||= build_resource
  end
end
