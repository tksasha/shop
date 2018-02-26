class AuthTokenDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    { auth_token: id, user: user }
  end
end
