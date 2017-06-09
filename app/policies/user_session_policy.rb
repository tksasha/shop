class UserSessionPolicy < ApplicationPolicy
  def new?
    !user.present?
  end

  def create?
     new? && !resource.user_blocked?
  end

  def destroy?
    user.present?
  end
end
