class CategoriesController < ApplicationController
  private
  def collection
    @collection ||= CategorySearcher.search name: params[:name]
  end

  def resource
    @resource ||= Category.find_by! slug: params[:id]
  end
end
