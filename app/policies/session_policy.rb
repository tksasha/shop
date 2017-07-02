class SessionPolicy < ApplicationPolicy
  def new?
    !user.present?
  end

  def create?
    new? && !resource.user_blocked? && resource.user_confirmed?
  end

  def destroy?
    user.present?
  end
end
