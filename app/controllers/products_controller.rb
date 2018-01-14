class ProductsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index)

  def show
    render pdf: 'show'
  end

  private
  def collection
    @collection ||= ProductSearcher.search(params).order(:name).page(params[:page])
  end
end
