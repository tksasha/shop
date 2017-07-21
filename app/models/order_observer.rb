class OrderObserver < ActiveRecord::Observer
  def after_create order
    #
    # current_user.purchases.update order: order
    # how to get current user here?
    #
  end
end
