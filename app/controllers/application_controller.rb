class ApplicationController < ActionController::Base
  include ActsAsAuthenticatedController
  include ActsAsRESTController
  include ActsAsAuthorizedController

  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
