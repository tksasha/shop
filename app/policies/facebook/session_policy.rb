module Facebook
  class SessionPolicy < ApplicationPolicy
    def create?
      !user.present?
    end
  end
end
