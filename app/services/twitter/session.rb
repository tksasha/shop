module Twitter
  class Session
    include ActsAsSession

    attr_accessor :oauth_token, :oauth_token_secret

    validates :oauth_token, :oauth_token_secret, presence: true

    validate :response_must_be_valid

    def initialize params={}
      @oauth_token = params[:oauth_token]

      @oauth_token_secret = params[:oauth_token_secret]
    end

    private
    def user
      return unless response.is_a? Net::HTTPOK

      json = JSON.parse response.body

      @user ||= User.find_or_create_by(twitter_id: json['id_str']) do |user|
        user.email = json['email']
      end
    end

    def token_hash
      { oauth_token: oauth_token, oauth_token_secret: oauth_token_secret }
    end

    def consumer
      OAuth::Consumer.new \
        ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET'], { site: 'https://api.twitter.com', scheme: :header }
    end

    def access_token
      OAuth::AccessToken.from_hash consumer, token_hash
    end

    def response
      @response ||= access_token.request :get, 'https://api.twitter.com/1.1/account/verify_credentials.json'
    end

    def response_must_be_valid
      return if oauth_token.blank? || oauth_token_secret.blank?

      unless response.is_a? Net::HTTPOK
        errors.add :oauth_token, :invalid

        errors.add :oauth_token_secret, :invalid
      end
    end
  end
end
