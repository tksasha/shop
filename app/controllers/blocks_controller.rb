class BlocksController < ApplicationController
  private
  def resource_params
    User.find params[:user_id]
  end

  def create_success_callback
    head :no_content
  end

  def create_failure_callback
    head :no_content
  end
end
