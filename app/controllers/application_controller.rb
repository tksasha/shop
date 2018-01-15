class ApplicationController < ActionController::Base
  include ActsAsAuthenticatedController

  before_action :build_resource, only: :create

  helper_method :parent, :collection, :resource

  include ActsAsAuthorizedController

  before_action -> { response.status = 201 }, only: :create
end
