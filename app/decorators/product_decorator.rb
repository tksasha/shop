class ProductDecorator < Draper::Decorator
  delegate_all

  def converted_price
    h.current_user.convert price
  end

  def formated_price
    h.current_user.format_currency price
  end
end
