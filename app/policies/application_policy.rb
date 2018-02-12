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
    create?
  end

  def create?
    false
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
