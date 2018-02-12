class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.roles?(:admin)
  end

  def create?
    !user.present?
  end

  def update?
    user.present? && (user.roles?(:admin) || user == resource)
  end

  def show?
    user.present? && user.id == resource.id
  end
end
