class ConfirmationsController < ApplicationController
  skip_before_action :authenticate!, only: [:index, :show]

  after_action -> { resource.confirm }, only: :show

  private
  alias_method :collection, :resource_model
end
