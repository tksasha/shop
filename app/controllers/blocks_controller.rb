class BlocksController < ApplicationController
  include Rest

  include Authorization

  private
  alias_method :resource, :build_resource

  def resource_params
    User.find params[:user_id]
  end

  def destroy_callback
    respond_to do |format|
      format.html { redirect_to resource_sym }

      format.json { head :no_content }

      format.js { render }
    end
  end
end
