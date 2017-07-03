class ProductPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  alias_method :show?, :index?
end