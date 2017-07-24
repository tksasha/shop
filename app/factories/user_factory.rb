class UserFactory < ApplicationFactory
  private
  def params
    @params.merge(roles: :user, confirmation_token: SecureRandom.uuid)
  end
end
