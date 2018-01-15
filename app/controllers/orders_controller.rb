class OrdersController < ApplicationController
  def create
    render :errors, status: 422 unless resource.save
  end

  private
  attr_reader :resource

  def build_resource
    @resource = OrderFactory.build current_user
  end
end
