class ApplicationPolicy
  attr_reader :user, :resource

  def initialize(user, resource)
    @user = user

    @resource = resource
  end

  def index?
    false
  end

  def show?
    false
  end

  def new?
    false
  end

  def create?
    new?
  end

  def edit?
    false
  end

  def update?
    edit?
  end

  def destroy?
    false
  end
end
