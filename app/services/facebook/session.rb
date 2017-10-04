module Facebook
  class Session
    include ActiveModel::Model

    REMOTE_API = "https://graph.facebook.com/me?fields=id,email"

    attr_accessor :access_token

    attr_reader :id, :user

    validates_presence_of :access_token

    validate :access_token_must_be_valid

    def initialize params
      @access_token = params[:access_token]
    end

    def save
      return false unless valid?

      find_or_create_user

      create_auth_token

      @persisted = true
    end

    def persisted?
      !!@persisted
    end

    private
    def response
      JSON.parse open("#{ REMOTE_API }&access_token=#{ @access_token }").read
    rescue OpenURI::HTTPError
      @response = {}
    end

    def auth_token
      @auth_token ||= SecureRandom.uuid
    end

    def access_token_must_be_valid
      errors.add :access_token, I18n.t('errors.messages.invalid') if response.blank?
    end

    def find_or_create_user
      @user = User.find_or_create_by(facebook_id: response['id']) { |user| user.email = response['email'] }
    end

    def create_auth_token
      user.auth_tokens.create value: auth_token
    end
  end
end
