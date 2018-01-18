class Version < ApplicationRecord
  delegate :as_json, to: :decorate
end
