class PurchaseFactory
  delegate :price, to: :product

  def initialize user_id, params={}
    @params = params

    @user_id = user_id
  end

  def build
    Purchase.new @params.merge(user_id: @user_id, price: price)
  end

  private
  def product
    @product ||= Product.find @params[:product_id]
  end

  class << self
    def build *args
      new(*args).build
    end
  end
end
