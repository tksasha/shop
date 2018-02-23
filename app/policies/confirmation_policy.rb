class ConfirmationPolicy < ApplicationPolicy
  def create?
    !user.present?
  end
end
