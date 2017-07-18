class PurchasePolicy < ApplicationPolicy
  def create?
    user.present?
  end
end
