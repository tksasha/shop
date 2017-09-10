class ProductDecorator < Draper::Decorator
  delegate_all

  def price params={}
    currency = h.current_user.currency

    params[:format] ? currency.formated_convert(model.price) : currency.convert(model.price)
  end
end
