class CategoriesController < ApplicationController
  skip_before_action :authenticate!, only: :index

  private
  def collection
    @collection ||= CategorySearcher.search Category.order(:slug), params
  end
end
