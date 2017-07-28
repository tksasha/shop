class CategoriesController < ApplicationController
  private
  #
  # GET /categories[?name=...]
  #
  def collection
    @collection ||= params[:name] ? Category.find_by_name(params[:name]) : Category.all
  end
end
