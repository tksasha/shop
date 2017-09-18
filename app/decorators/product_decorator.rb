class ProductDecorator < Draper::Decorator
  delegate_all

  delegate :current_user, to: :h

  def converter
    @converter ||= Converter.new to: current_user.currency, from: :usd
  end

  def price
    converter.convert product.price
  end
end
