class UserFactory
  def initialize params={}
    @params = params
  end

  def build
    User.new @params.merge(role: :user, blocked: false)
  end

  class << self
    def build *args
      new(*args).build
    end
  end
end
