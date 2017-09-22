class CategoriesController < ApplicationController
  private
  def collection
    @collection ||= CategorySearcher.search name: params[:name]
  end
end
