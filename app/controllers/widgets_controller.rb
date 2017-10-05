class WidgetsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  skip_before_action :authorize_collection, only: :index

  layout 'widgets'
end
