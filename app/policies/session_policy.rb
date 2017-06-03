class SessionPolicy < ApplicationPolicy
  def new?
    !user.present?
  end

  def destroy?
    user.present?
  end
end
