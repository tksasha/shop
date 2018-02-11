class AuthToken < ApplicationRecord
  delegate :as_json, to: :decorate

  belongs_to :user
end
