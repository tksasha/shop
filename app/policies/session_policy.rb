class SessionPolicy < ApplicationPolicy
  def new?
    !user.present?
  end
end
