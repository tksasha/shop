class BlockPolicy < ApplicationPolicy
  def create?
    user.present? && user.roles?(:admin)
  end

  alias_method :destroy?, :create?
end
