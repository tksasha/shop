class SessionPolicy < ApplicationPolicy
  def new?
    !user.present? && resource.user_not_blocked?
  end

  def destroy?
    user.present?
  end
end
