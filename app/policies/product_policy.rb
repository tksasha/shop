class ProductPolicy < ApplicationPolicy
  def index?
    user.present?
  end
end