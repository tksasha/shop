class PurchaseFactory < ApplicationFactory
  def initialize user_id, params={}
    @params = params

    @user_id = user_id
  end

  private
  def params
    @params.merge(user_id: @user_id, price: price)
  end

  def price
    @price ||= product.price * @params[:amount]
  end

  def product
    @product ||= Product.find @params[:product_id]
  end
end
