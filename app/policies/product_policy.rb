class ProductPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  alias_method :show?, :index?

  def destroy?
    user.present? && user.roles?(:admin)
  end

  def new?
    user.present? && user.roles?(:admin)
  end
end
