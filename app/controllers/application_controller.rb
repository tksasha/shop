class ApplicationController < ActionController::Base
  include ActsAsAuthenticatedController
  include ActsAsAuthorizedController

  before_action -> { response.status = 201 }, only: :create
end
