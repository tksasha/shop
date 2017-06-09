class BlockPolicy < ApplicationPolicy
  def create?
    user.present? && user.roles?(:admin)
  end
end
