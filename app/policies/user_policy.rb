class UserPolicy < ApplicationPolicy
  def new?
    !user.present?
  end

  def show?
    user.id == resource.id
  end
end
