class ProductPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def new?
    user.present? && user.roles?(:admin)
  end
end