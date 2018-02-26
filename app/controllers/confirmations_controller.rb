class ConfirmationsController < ApplicationController
  skip_before_action :authenticate!, only: :create

  def create
    if resource.save
      head 204
    else
      render :errors, status: 422
    end
  end

  private
  attr_reader :resource

  def resource_params
    params.require(:confirmation).permit(:token)
  end

  def build_resource
    @resource = Confirmation.new resource_params
  end
end
