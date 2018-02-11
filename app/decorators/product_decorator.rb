class ProductDecorator < Draper::Decorator
  delegate_all

  delegate :current_user, to: :h

  delegate :currency, to: :current_user, prefix: true, allow_nil: true

  def as_json *args
    {
      id: id,
      name: name,
      image: image_url,
      description: description,
      amount: amount,
      price: price,
      discount_price: discount_price
    }
  end

  def image_url
    h.image_url image.url :'500x500'
  end

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
