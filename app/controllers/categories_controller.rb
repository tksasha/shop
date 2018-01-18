class CategoriesController < ApplicationController
  private
  def collection
    @collection ||= CategorySearcher.search Category.order(:slug), params
  end
end
