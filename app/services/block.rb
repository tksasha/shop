class Block
  attr_reader :user

  def initialize user_id
    @user = User.find user_id
  end

  def save
    @user.auth_tokens.destroy_all

    @user.touch :blocked_at
  end

  def destroy
    @user.update blocked_at: nil
  end
end