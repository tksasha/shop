class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  alias_method :show?, :index?

  def change?
    user.present? && user.roles?(:admin)
  end

  alias_method :create?, :change?

  alias_method :update?, :change?

  alias_method :destroy?, :change?
end
