module ActsAsSession
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model

    alias_method :save, :valid?
  end

  delegate :as_json, to: :auth_token, allow_nil: true

  def persisted?
    false
  end

  def auth_token
    @auth_token ||= user&.auth_tokens&.create!
  end
end
