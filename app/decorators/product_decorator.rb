class ProductDecorator < Draper::Decorator
  delegate_all

  delegate :current_user, to: :h

  delegate :currency, to: :current_user, prefix: true, allow_nil: true

  def price
    @price ||= convert_currency product.price
  end

  def discount_price
    @discount_price ||= convert_currency product.discount_price if product.discount_price.present?
  end

  private
  def convert_currency sum
    CurrencyConverter.convert from: product.currency, to: current_user_currency, sum: sum
  end
end
