class ProfilePolicy < ApplicationPolicy
  def show?
    user.id == resource.id
  end
end
