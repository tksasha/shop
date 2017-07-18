class PurchaseFactory
  def initialize user_id, params={}
    @params = params

    @user_id = user_id

    @price = Product.find(params[:product_id]).price
  end

  def build
    Purchase.new @params.merge(user_id: @user_id, price: @price)
  end

  class << self
    def build *args
      new(*args).build
    end
  end
end
