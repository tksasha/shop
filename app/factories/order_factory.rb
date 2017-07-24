class OrderFactory < ApplicationFactory
  def initialize user, params={}
    @user = user

    @params = params
  end

  private
  def params
    @params.merge(purchases: @user.purchases.cart, user: @user, total: total)
  end

  def total
    @total ||= @user.purchases.cart.sum :price
  end
end
