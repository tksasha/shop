class CategoriesController < ApplicationController
  private
  def collection
    @collection ||= CategorySearcher.search params
  end
end
