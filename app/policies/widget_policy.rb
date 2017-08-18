class WidgetPolicy < ApplicationPolicy
  def index?
    !!user&.roles?(:admin)
  end
end
