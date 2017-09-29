module Facebook
  class Session
    include ActiveModel::Model

    validate :facebook_user_must_exist, :user_must_exist, :user_must_not_be_blocked, :auth_token_must_be_present

    attr_reader :id, :auth_token

    REMOTE_API = "https://graph.facebook.com/me?fields=id,email"

    def initialize params
      @access_token = params[:access_token]
    end

    def save
      @persisted = valid?
    end

    def persisted?
      !!@persisted
    end

    private
    def facebook_user
      @facebook_user ||= JSON.parse open("#{ REMOTE_API }&access_token=#{ @access_token }").read
    end

    def user
      @user ||= User.find_or_create_by(facebook_id: facebook_user['id']) do |u|
        u.email = facebook_user['email']
      end if facebook_user.present?
    end

    def user_must_exist
      errors.add :access_token, I18n.t('facebook.session.error.validation') unless user.present?
    end

    def facebook_user_must_exist
      errors.add :access_token, I18n.t('facebook.session.error.validation') unless facebook_user.present?
    end

    def auth_token_must_be_present
      if user.present?
        token = user.auth_tokens.build(value: SecureRandom.uuid)

        if token.save
          @auth_token = token.value
        else
          errors.add :auth_token, I18n.t('errors.messages.blank')
        end
      end
    end

    def user_must_not_be_blocked
      errors.add :user, I18n.t('facebook.session.error.blocked') if user&.decorate&.blocked?
    end
  end
end
