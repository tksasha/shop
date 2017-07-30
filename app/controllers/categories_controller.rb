class CategoriesController < ApplicationController
  private
  #
  # GET /categories[?name=...]
  #
  def collection
    @collection ||= CategorySearcher.search name: params[:name]
  end
end
