class OrdersController < ApplicationController
  private
  def build_resource
    @resource = OrderFactory.build current_user
  end
end
