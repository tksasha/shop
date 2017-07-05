class ProductPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def destroy?
    user.present? && user.roles?(:admin)
  end

  alias_method :show?, :index?
end