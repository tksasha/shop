class ProductDecorator < Draper::Decorator
  delegate_all

  delegate :current_user, to: :h

  delegate :currency, to: :current_user, prefix: true

  def price
    @price ||= CurrencyConverter.convert from: product.currency, to: current_user_currency, sum: product.price
  end
end
