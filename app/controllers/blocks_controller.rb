class BlocksController < ApplicationController
  private
  def resource_params
    User.find params[:user_id]
  end

  def create_success_callback
    flash.now[:success] = 'User was blocked'
  end

  def create_failure_callback
    flash.now[:danger] = 'User was not blocked'
    
    render :errors
  end
end
