class OrderPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end
