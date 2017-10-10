module Facebook
  class Session
    include ActiveModel::Model

    REMOTE_API = 'https://graph.facebook.com/me?fields=id,email'

    attr_accessor :access_token, :id

    validates :access_token, presence: true

    validate :access_token_must_be_valid

    def initialize params
      @access_token = params[:access_token]
    end

    def save
      return false unless valid?

      @persisted = !!create_auth_token&.persisted?
    end

    def persisted?
      !!@persisted
    end

    private
    def response
      @response ||= JSON.parse open("#{ REMOTE_API }&access_token=#{ @access_token }").read
    rescue OpenURI::HTTPError
      @response = {}
    end

    def auth_token
      @auth_token ||= SecureRandom.uuid
    end

    def access_token_must_be_valid
      errors.add :access_token, I18n.t('errors.messages.invalid') if response.blank?
    end

    def user
      @user ||= User.find_or_create_by(facebook_id: response['id']) { |user| user.email = response['email'] }
    end

    def create_auth_token
      return if user.blank?
      
      user.auth_tokens.create value: auth_token
    end
  end
end
