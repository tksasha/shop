class PurchasePolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.present? && user.id == resource.user_id
  end
end
