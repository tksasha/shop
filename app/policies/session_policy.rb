class SessionPolicy < ApplicationPolicy
  def new?
    !user.present? && !resource.blocked
  end

  def destroy?
    user.present?
  end
end
