class CategoryPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present? && user.roles?(:admin)
  end
end
