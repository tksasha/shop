class Block
  attr_reader :user

  def initialize user
    @user = user
  end

  def save
    @user.auth_tokens.destroy_all

    @user.update blocked_at: DateTime.now
  end

  def destroy
    @user.update blocked_at: nil
  end
end