class UserDecorator < Draper::Decorator
  delegate_all

  decorates_finders

  def blocked?
    model.blocked_at.present?
  end

  def blocked_at
    blocked? ? I18n.l(model.blocked_at) : I18n.t(false)
  end
end
