class ConfirmationPolicy < ApplicationPolicy
  def show?
    !user.present?
  end

  alias_method :index?, :show?
end
