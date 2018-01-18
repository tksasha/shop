module Facebook
  class Session
    include ActiveModel::Model

    delegate :as_json, to: :auth_token, allow_nil: true

    REMOTE_API = 'https://graph.facebook.com/me?fields=id,email'

    attr_accessor :access_token

    validates :access_token, presence: true

    validate :access_token_must_be_valid

    def initialize params
      @access_token = params[:access_token]
    end

    def persisted?
      false
    end

    def auth_token
      @auth_token ||= user&.auth_tokens&.create!
    end

    alias_method :save, :valid?

    private
    def user
      return if response.blank? || response['id'].blank?

      @user ||= User.find_or_create_by(facebook_id: response['id']) do |user|
        user.email = response['email']
      end
    end

    def response
      @response ||= JSON.parse open("#{ REMOTE_API }&access_token=#{ @access_token }").read
    rescue OpenURI::HTTPError
      @response = {}
    end

    def access_token_must_be_valid
      errors.add :access_token, :invalid if response.blank? || response['id'].blank?
    end
  end
end
