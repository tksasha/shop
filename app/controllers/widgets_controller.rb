class WidgetsController < ApplicationController
  layout 'widgets'

  private
  def collection
    Widget
  end
end
