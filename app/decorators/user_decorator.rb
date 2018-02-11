class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      email: email,
      roles: roles,
      currency: currency
    }
  end

  def blocked?
    model.blocked_at.present?
  end

  def blocked_at
    blocked? ? I18n.l(model.blocked_at) : I18n.t(false)
  end
end
