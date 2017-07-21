class OrdersController < ApplicationController
  private
  def build_resource
    @resource = Order.new purchases: current_user.purchases.where(order_id: nil)
  end
end
