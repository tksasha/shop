class Confirmation
  include ActiveModel::Model

  attr_reader :user

  delegate :persisted?, to: :user

  def initialize user
    @user = user
  end

  def confirm
    user.update(confirmed: true)
  end

  def to_param
    user.confirmation_token
  end

  class << self
    def find token
      user = User.find_by! confirmation_token: token

      Confirmation.new user
    end
  end
end
