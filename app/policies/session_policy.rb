class SessionPolicy < ApplicationPolicy
  def new?
    !user.present?
  end

  def create?
    !user.present? && resource.user_not_blocked? && resource.user_confirmed?
  end

  def destroy?
    user.present?
  end
end
