class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  alias_method :show?, :index?

  def change?
    user.present? && user.roles?(:admin)
  end

  alias_method :new?, :change?

  alias_method :edit?, :change?

  alias_method :destroy?, :change?
end
