class ApplicationController < ActionController::Base
  include ActsAsRESTController
  include ActsAsAuthenticatedController
  include ActsAsAuthorizedController

  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
